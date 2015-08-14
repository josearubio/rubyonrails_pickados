module PicksHelper
  def ownpick?(pick)
    current_user.picks.include?(pick)
  end
end
