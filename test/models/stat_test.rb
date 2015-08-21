require 'test_helper'

class StatTest < ActiveSupport::TestCase
  def setup
  @user = users(:prueba)
  @userb=users(:segundo)
  @picka=picks(:one)
  @pickb=picks(:onea)

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
    @stat = @user.create_stat_if_not("2015-08-08 10:30:14".to_time)
    #assert_equal nil,@user.create_stat_if_not("2014-08-08 10:30:14".to_time)
    assert_not @user.feed.empty?
    #assert_not @userb.stats.any?
    @userb.create_stat_if_not("2015-08-30 10:30:14".to_time)
    assert @userb.stats.any?

  end

  test "add pick on stat" do
    @picka.addonstats
    assert_equal 1,@picka.user.stats.first.totalpicks
    assert_equal 1,@picka.user.stats.first.acertadas
    assert_equal 0,@picka.user.stats.first.falladas
    assert_equal 1,@picka.user.stats.first.profit
    @pickb.addonstats
    assert_equal 2,@picka.user.stats.first.totalpicks
    assert_equal 1,@picka.user.stats.first.acertadas
    assert_equal 1,@picka.user.stats.first.falladas
    assert_equal 4,@picka.user.stats.first.totalstaked
    assert_equal 1.5,@picka.user.stats.first.cuotaavg
    assert_equal -1,@picka.user.stats.first.profit
    assert_equal -25,@picka.user.stats.first.yield
    @pickb.addonstats
    @pickb.addonstats
    @pickb.addonstats
    assert_equal 5,@picka.user.stats.first.totalpicks
    assert_equal 1,@picka.user.stats.first.acertadas
    assert_equal 4,@picka.user.stats.first.falladas
    assert_equal 4,@user.stats.first.falladas

  end

end
