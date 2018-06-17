require 'test_helper'

class DayOfDayOfMonthTest < Minitest::Test
  def test_field_range
    result = Crntb::DayOfMonth.new('*').field_range
    assert_equal result, 0..31
  end

  def test_parse
    result = Crntb::DayOfMonth.new('*').parse
    assert_equal result, ""

    result = Crntb::DayOfMonth.new('1,2,3').parse
    assert_equal result, "on the 1, 2, 3"

    result = Crntb::DayOfMonth.new('10-13').parse
    assert_equal result, "on the 10, 11, 12, 13"

    result = Crntb::DayOfMonth.new('*/11').parse
    assert_equal result, "on the 11, 22"
  end
end
