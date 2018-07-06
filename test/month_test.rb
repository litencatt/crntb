require 'test_helper'

class DayOfMonthTest < Minitest::Test
  def test_field_range
    result = Crntb::Month.new('*').field_range
    assert_equal result, 1..12
  end

  def test_parse
    result = Crntb::Month.new('*').parse
    assert_equal result, "*"

    result = Crntb::Month.new('1,2,3').parse
    assert_equal result, "January, February, March"

    result = Crntb::Month.new('8-10').parse
    assert_equal result, "August, September, October"

    result = Crntb::Month.new('*/3').parse
    assert_equal result, "January, April, July, October"

    result = Crntb::Month.new('jan').parse
    assert_equal result, "January"

    result = Crntb::Month.new('jun-sep').parse
    assert_equal result, "June, July, August, September"
  end
end
