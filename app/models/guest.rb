class Guest < ActiveRecord::Base
  attr_accessible :amount_paid, :amount_should_have_paid, :bill_id, :user_id, :username

  belongs_to :user
  belongs_to :bill
end
