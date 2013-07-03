class Friendship < ActiveRecord::Base  
  attr_accessible :friend_id, :user_id

  belongs_to :user

  belongs_to :friend,
    :class_name => "User",
    :foreign_key => :friend_id
    
    # validate :only_one_friendship_between_two_people
    #   
    # def only_one_friendship_between_two_people
    #   if Friendship.where(:user_id => user_id, :friend_id => friend_id) || Friendship.where(:user_id => friend_id, :friend_id => user_id)
    #     errors[:already_friends] << "You are already friends."
    #   end
    # end
end