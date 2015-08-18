require 'test_helper'

class StatTest < ActiveSupport::TestCase
  def setup
  @user = users(:prueba)

  @stat = @user.stats.build()
    @stato=stats(:one)
  end

   test "new stat" do
     assert @stat.valid?
     @stat = Stat.new()
     assert_equal 0,@stat.acertadas
     assert_not @stat.valid?

   end

  test "must create if not exist" do
    @stat = @user.stats.build()
    #assert_equal @stato.created_at.month,"2015-08-08 10:30:14".to_time.month
    #assert_equal 2015,"2015-08-08 10:30:14".to_time.year
   # assert_equal strftime('%Y', "2015-08-08 10:30:14".to_time), 2015
    #assert @user.create_stat_if_not("2011-05-19 10:30:14".to_time).first.nil?
    assert_not @user.create_stat_if_not("2015-08-08 10:30:14".to_time).empty?
    assert_not @user.feed.empty?
  end
end
