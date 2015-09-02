require 'test_helper'

class FavoriteTest < ActiveSupport::TestCase
  test "should fav and unfav a pick" do
    prueba = users(:prueba)
    one = picks(:one)
    assert_not prueba.faving?(one)
    prueba.fav(one)
    assert prueba.faving?(one)
    assert one.favedby?(prueba)
    prueba.unfav(one)
    assert_not prueba.faving?(one)
  end
end
