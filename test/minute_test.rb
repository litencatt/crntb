require 'test_helper'

class MinuteTest < Minitest::Test
  def test_field_range
    result = Crntb::Minute.new('*').field_range
    assert_equal result, 0..59
  end

  def test_parse
    result = Crntb::Minute.new('*').parse
    assert_equal result, "every minute"

    result = Crntb::Minute.new('10-15').parse
    assert_equal result, "when minute equals 10, 11, 12, 13, 14, 15"

    result = Crntb::Minute.new('*/10').parse
    assert_equal result, "when minute equals 0, 10, 20, 30, 40, 50"
  end
end
