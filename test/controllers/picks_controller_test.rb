require 'test_helper'

class PicksControllerTest < ActionController::TestCase
  def setup
    @pick = picks(:one)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Pick.count' do
      post :create, pick: { evento: "Madrid-Barcelona",pronostico: "Gana Barcelona" }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Pick.count' do
      delete :destroy, id: @pick
    end
    assert_redirected_to login_url
  end
end
