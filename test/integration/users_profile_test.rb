require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:prueba)
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'h1', text: @user.name
    assert_select 'h1>img.gravatar'
    assert_match @user.picks.count.to_s, response.body
    #assert_select 'div.pagination'
    @user.picks.paginate(page: 1).each do |pick|
      assert_match pick.evento, response.body
    end
  end
end
