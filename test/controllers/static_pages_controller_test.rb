require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase

  def setup
    @user = users(:prueba)
  end

  test "should get mispicks" do
    get :mispicks, id: @user
    assert_response :success
  end

  test "should get faq" do
    get :faq
    assert_response :success
  end

  test "should get contacto" do
    get :contacto
    assert_response :success
  end

end
