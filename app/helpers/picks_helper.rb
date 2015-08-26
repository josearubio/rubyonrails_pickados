module PicksHelper
  def ownpick?(pick)
    current_user.picks.include?(pick)
  end
  def isOnTime(pick)
    if pick.created_at > Time.now-9*60
      true
    else
      false
    end
  end
end
