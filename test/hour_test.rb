require 'test_helper'

class HourTest < Minitest::Test
  def test_field_range
    result = Crntb::Hour.new('*').field_range
    assert_equal result, 0..23
  end

  def test_parse
    result = Crntb::Hour.new('*').parse
    assert_equal result, "every hour"

    result = Crntb::Hour.new('1,2,3').parse
    assert_equal result, "1, 2, 3"

    result = Crntb::Hour.new('10-13').parse
    assert_equal result, "10, 11, 12, 13"

    result = Crntb::Hour.new('*/6').parse
    assert_equal result, "0, 6, 12, 18"
  end
end
