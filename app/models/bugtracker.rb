class Bugtracker < ActiveRecord::Base
  has_many :comments
end
