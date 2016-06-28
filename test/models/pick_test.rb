require 'test_helper'

class PickTest < ActiveSupport::TestCase
  def setup
    @user = users(:prueba)

    @pick = @user.picks.build(evento: "Madrid-Barcelona",pronostico: "Gana Barcelona",categoria: "LIGA", deporte:"futbol",
                              cuota: 2, stake: 3, pickdate:"2015-08-31 20:00",bookie: "bet365")
    @pick2 = @user.picks.build(evento: "Paco-Paco",pronostico: "Gana Paco",categoria: "LIGA", deporte:"futbol",
                              cuota: 2, stake: 3, pickdate:"2015-08-31 20:00",bookie: "bet365")
    @pick3 = @user.picks.build(evento: "Paco-Paaaaa",pronostico: "Gana Pacaaaaaao",categoria: "LIGA", deporte:"futbol",
                               cuota: 2, stake: 3, pickdate:"2015-08-31 20:00",bookie: "bet365")
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid and date" do
    assert @pick.valid?
    assert "August", @pick.pickdate.strftime("%B")
  end

  test "combinadas" do
    assert_not @pick.picks.include?(@pick2)
    @pick.save
    assert_equal(2,@pick.cuota)
    @pick.addpick(@pick2)
    assert @pick.picks.include?(@pick2)
    @pick.addpick(@pick3)
    assert @pick.picks.include?(@pick3)
    #pick.picks.delete(Pick.find @pick2.id) #TAMBIEN @pick.picks.delete(@pick2)
    #@pick.picks.delete(@pick2)
    #assert_not @pick.picks.include?(@pick2)
    #assert @pick.picks.include?(@pick3)
    assert @pick.comb
    assert_not @pick3.show

    #COMPROBAMOS CUOTA MODIFICADA

    assert_equal(8,@pick.cuota)



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

  test "associated picks should be destroyed" do
    @user.save
    @user.picks.create!(evento: "Madrid-Barcelona",pronostico: "Gana Barcelona",categoria: "LIGA", deporte:"futbol",
                        cuota: 2, stake: 3, pickdate:"2015-08-31 20:00",bookie: "Bet365")
    assert_difference 'Pick.count', -1 do
      @user.destroy
    end
  end

  test "status unstarted by default" do
    assert_equal 'unstarted',@pick.status
    @pick.setstarted
    assert_equal 'started',@pick.status
    result = 'hola'
    @pick.setticked(result)

    assert_equal 'ticked',@pick.status
  end
end
