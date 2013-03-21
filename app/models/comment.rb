class Comment < ActiveRecord::Base
  attr_accessible :content, :place_id, :user_id
  
  belongs_to :place
  belongs_to :user
end
