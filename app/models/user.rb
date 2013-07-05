require 'bcrypt'

class User < ActiveRecord::Base
  attr_accessible :password, :username, :email
  attr_reader :password

  validates :username, :password_digest, :presence => true
  validates :email, :uniqueness => true
  validates :password, :length => { :minimum => 3 }
  
  has_many :friendships
  has_many :friends, 
    :through => :friendships,
    :class_name => "User"
    
  has_many :inverse_friendships, 
    :class_name => "Friendship", 
    :foreign_key => "friend_id"
  has_many :inverse_friends, 
    :through => :inverse_friendships, 
    :source => :user
  
  has_many :debts,
    :foreign_key => "debtor_id"
    
  has_many :credits, 
    :class_name => "Debt",
    :foreign_key => "creditor_id"

  has_many :debtors,
    :through => :credits
    # :source => :debtor
    
  has_many :creditors, 
    :through => :debts
    # :source => :creditor

  has_many :bills, 
    :through => :debts,
    :foreign_key => :debtor_id
  
  has_many :invoices,
    :through => :credits,
    :source => :bill,
    :foreign_key => :creditor_id
    
  has_many :nudges
  
  has_many :received_nudges,
    :class_name => "Nudge",
    :foreign_key => "friend_id"

  def password
    @password || self.password_digest
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def verify_password(password)
    BCrypt::Password.new(self.password_digest) == password
  end
  
  def get_history
    history_array = []
    
    self.friends.each do |friend|
      history_array += self.get_payment_history_with(friend)
    end
    
    self.inverse_friends.each do |friend|
      history_array += self.get_payment_history_with(friend)
    end
    
    self.sort_payment_history(history_array)
  end
  
  def settled_up?
    self.money_owed_to_friends == 0
  end

  def money_owed_by_friends
    money_owed = 0
    
    self.friends.each do |friend|
      my_debt = self.calculate_debt_to(friend)
      money_owed += my_debt if my_debt < 0
    end
    
    self.inverse_friends.each do |friend|
      my_debt = self.calculate_debt_to(friend)
      money_owed += my_debt if my_debt < 0
    end
    
    money_owed.abs
  end
  
  def money_owed_to_friends
    money_owed = 0
    
    self.friends.each do |friend|
      my_debt = self.calculate_debt_to(friend)
      money_owed += my_debt if my_debt > 0
    end
    
    self.inverse_friends.each do |friend|
      my_debt = self.calculate_debt_to(friend)
      money_owed += my_debt if my_debt > 0
    end

    money_owed.abs
  end
  
  def calculate_debt_to(other_user)
    payment_history = self.get_payment_history_with(other_user)
    
    money_i_owe = 0
    money_owed_to_me = 0
    
    payment_history.each do |payment|
      money_owed_to_me += payment.amount if payment.creditor_id == self.id
      money_i_owe += payment.amount if payment.debtor_id == self.id
    end
    
    money_i_owe - money_owed_to_me
  end
  
  def payments_received
    payment_array = []
    
    self.debts.each do |debt|
      payment_array.push(debt) if debt.is_a_payment == true
    end
    
    payment_array
  end
  
  def payments_sent
    payment_array = []
    
    self.credits.each do |credit|
      payment_array.push(credit) if credit.is_a_payment == true
    end
    
    payment_array
  end
  
  def get_payment_history_with(other_user)
    payment_history = []
    
    self.debts.each do |debt|
      payment_history.push(debt) if debt.creditor_id == other_user.id
    end
    
    self.credits.each do |credit|
      payment_history.push(credit) if credit.debtor_id == other_user.id
    end
    
    self.payments_sent.each do |payment| # double check this one!
      payment_history.push(payment) if payment.debtor_id == other_user.id
    end   
    
    self.payments_received.each do |payment| # double check this one too!
      payment_history.push(payment) if payment.creditor_id == other_user.id
    end
    
    sort_payment_history(payment_history.uniq)
  end
  
  def sort_payment_history(history_array)
    (history_array.sort_by { |payment| payment[:created_at] } ).reverse
  end
end