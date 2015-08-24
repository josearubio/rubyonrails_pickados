require 'test_helper'

class PicksInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:prueba)
  end

  test "pick interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    # Invalid submission
    assert_no_difference 'Pick.count' do
      post picks_path, pick: { evento: "" }
    end
    assert_select 'div#error_explanation'
    # Valid submission
    assert_difference 'Pick.count', 1 do
      post picks_path, pick: { evento: "Madrid-Barcelona",pronostico: "Gana Barcelona",categoria: "LIGA", deporte:"futbol",
                               cuota: 2, stake: 3, pickdate:"2015-08-31 20:00" }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match "Madrid-Barcelona", response.body
    # Delete a post.
    #assert_select 'a', text: 'delete'
    first_pick = @user.picks.paginate(page: 1).first
    assert_difference 'Pick.count', -1 do
      delete pick_path(first_pick)
    end
    # Visit a different user.
    get user_path(users(:segundo))
    assert_select 'a', text: 'delete', count: 0
  end
end
