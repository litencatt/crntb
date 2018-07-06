require 'test_helper'

class DayOfWeekTest < Minitest::Test
  def test_field_range
    result = Crntb::DayOfWeek.new('*').field_range
    assert_equal result, 1..7
  end

  def test_parse
    result = Crntb::DayOfWeek.new('*').parse
    assert_equal result, ""

    result = Crntb::DayOfWeek.new('1,2,3').parse
    assert_equal result, "and on Mondays, Tuesdays, Wednesdays"

    result = Crntb::DayOfWeek.new('1-3').parse
    assert_equal result, "and on Mondays, Tuesdays, Wednesdays"

    result = Crntb::DayOfWeek.new('*/3').parse
    assert_equal result, "and on Wednesdays, Saturdays"
  end
end
