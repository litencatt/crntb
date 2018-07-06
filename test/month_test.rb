require 'test_helper'

class DayOfMonthTest < Minitest::Test
  def test_field_range
    result = Crntb::Month.new('*').field_range
    assert_equal result, 1..12
  end

  def test_parse
    result = Crntb::Month.new('*').parse
    assert_equal result, "every day"

    result = Crntb::Month.new('1,2,3').parse
    assert_equal result, "In January, February, March"

    result = Crntb::Month.new('8-10').parse
    assert_equal result, "In August, September, October"

    result = Crntb::Month.new('*/3').parse
    assert_equal result, "In March, June, September, December"
  end
end
