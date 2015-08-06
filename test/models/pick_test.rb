require 'test_helper'

class PickTest < ActiveSupport::TestCase
  def setup
    @user = users(:prueba)
    # This code is not idiomatically correct.
    @pick = @user.picks.build(evento: "Madrid-Barcelona",pronostico: "Gana Barcelona")
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @pick.valid?
  end

  test "user id should be present" do
    @pick.user_id = nil
    assert_not @pick.valid?
  end

  test "evento and pronostico should be present" do
    @pick.evento = "   "
    assert_not @pick.valid?
    @pick.evento = "Madrid-Barcelona"
    @pick.pronostico = "   "
    assert_not @pick.valid?


  end

  test "evento should be at most 75 characters" do
    @pick.evento = "a" * 79
    assert_not @pick.valid?
  end

  test "order should be most recent first" do
    assert_equal picks(:two), Pick.first
  end

  test "associated microposts should be destroyed" do
    @user.save
    @user.picks.create!(evento: "Madrid-Barcelona",pronostico: "Gana Barcelona")
    assert_difference 'Pick.count', -1 do
      @user.destroy
    end
  end
end
