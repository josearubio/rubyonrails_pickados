class Pick < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
	validates :evento, presence: true ,length: { maximum: 75 }
	validates :pronostico, presence: true

  def setstarted
    update_attribute(:status,'started')
  end
  def setticked(result)
    update_attribute(:status,'ticked')
  end
end
