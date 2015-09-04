class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :pick
  validates :pick_id, presence: true
  validates :user_id, presence: true
end
