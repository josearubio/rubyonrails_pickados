class Pick < ActiveRecord::Base
	 validates :evento, presence: true
	  validates :pronostico, presence: true
end
