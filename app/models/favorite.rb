class Favorite < ActiveRecord::Base
  belongs_to :owner, class_name: "User"
  belongs_to :favorited, class_name: "Pick"
  validates :pick_id, presence: true
  validates :user_id, presence: true
end
