require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end
  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "set pro" do
    @user.setprotipster
    assert_equal @user.pro, 1
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end

  test "should follow and unfollow a user" do
   prueba = users(:prueba)
    segundo  = users(:segundo)
    assert_not prueba.following?(segundo)
    prueba.follow(segundo)
    assert prueba.following?(segundo)
   assert segundo.followers.include?(prueba)
    prueba.unfollow(segundo)
    assert_not prueba.following?(segundo)
  end
  test "feed should have the right picks" do
    prueba = users(:prueba)
    tercero= users(:tercero)
    segundo= users(:segundo)
    # Posts from followed user
    tercero.picks.each do |post_following|
      assert prueba.feed.include?(post_following)
    end
    # Posts from self
    prueba.picks.each do |post_self|
      assert prueba.feed.include?(post_self)
    end
    # Posts from unfollowed user
    segundo.picks.each do |post_unfollowed|
      assert_not prueba.feed.include?(post_unfollowed)
    end
  end

end
