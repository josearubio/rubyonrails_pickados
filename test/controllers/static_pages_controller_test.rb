require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get mispicks" do
    get :mispicks
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
