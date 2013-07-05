class Nudge < ActiveRecord::Base
  attr_accessible :friend_id, :user_id, :viewed
  
  belongs_to :user
  belongs_to :friend,
    :class_name => "User",
    :foreign_key => :friend_id
end
