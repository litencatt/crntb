require 'test_helper'

class DayOfMonthTest < Minitest::Test
  def test_field_range
    result = Crntb::Month.new('*').field_range
    assert_equal result, 0..12
  end

  def test_parse
    result = Crntb::Month.new('*').parse
    assert_equal result, "every day "

    result = Crntb::Month.new('1,2,3').parse
    assert_equal result, "In 1, 2, 3"

    result = Crntb::Month.new('8-10').parse
    assert_equal result, "In 8, 9, 10"

    result = Crntb::Month.new('*/3').parse
    assert_equal result, "In 3, 6, 9, 12"
  end
end
