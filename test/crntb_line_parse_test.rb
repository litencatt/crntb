require 'test_helper'

class LineParseTest < Minitest::Test
  def test_parse
    result = Crntb.parse_line('* * * * * foo.sh')
    assert_equal result, %Q{every day on every hour on every minute\n  run command "foo.sh"}
  end

  def test_minute_parse
    result = Crntb.parse_line('10 * * * * foo.sh')
    assert_equal result, %Q{every day on every hour when minute equals 10\n  run command "foo.sh"}

    result = Crntb.parse_line('*/10 * * * * foo.sh')
    assert_equal result, %Q{every day on every hour when minute equals one of (00, 10, 20, 30, 40, 50)\n  run command "foo.sh"}

    result = Crntb.parse_line('5-10 * * * * foo.sh')
    assert_equal result, %Q{every day on every hour when minute equals one of (05, 06, 07, 08, 09, 10)\n  run command "foo.sh"}

    result = Crntb.parse_line('5,10 * * * * foo.sh')
    assert_equal result, %Q{every day on every hour when minute equals one of (05, 10)\n  run command "foo.sh"}
  end

  def test_hour_parse
    result = Crntb.parse_line('* 10 * * * foo.sh')
    assert_equal result, %Q{every day on every minute when hour is (10)\n  run command "foo.sh"}

    result = Crntb.parse_line('* */10 * * * foo.sh')
    assert_equal result, %Q{every day on every minute when hour is (00, 10, 20)\n  run command "foo.sh"}

    result = Crntb.parse_line('* 5-10 * * * foo.sh')
    assert_equal result, %Q{every day on every minute when hour is (05, 06, 07, 08, 09, 10)\n  run command "foo.sh"}

    result = Crntb.parse_line('* 5,10 * * * foo.sh')
    assert_equal result, %Q{every day on every minute when hour is (05, 10)\n  run command "foo.sh"}
  end

  def test_day_of_month_parse
    result = Crntb.parse_line('* * 10 * * foo.sh')
    assert_equal result, %Q{every month on the 10th on every hour on every minute\n  run command "foo.sh"}

    result = Crntb.parse_line('* * */10 * * foo.sh')
    assert_equal result, %Q{every month on the 1st, 11th, 21th, 31th on every hour on every minute\n  run command "foo.sh"}

    result = Crntb.parse_line('* * 5-10 * * foo.sh')
    assert_equal result, %Q{every month on the 5th, 6th, 7th, 8th, 9th, 10th on every hour on every minute\n  run command "foo.sh"}

    result = Crntb.parse_line('* * 5,10 * * foo.sh')
    assert_equal result, %Q{every month on the 5th, 10th on every hour on every minute\n  run command "foo.sh"}
  end

  def test_month_parse
    result = Crntb.parse_line('* * * 10 * foo.sh')
    assert_equal result, %Q{in October, on every day on every hour on every minute\n  run command "foo.sh"}

    result = Crntb.parse_line('* * * */10 * foo.sh')
    assert_equal result, %Q{in January, November, on every day on every hour on every minute\n  run command "foo.sh"}

    result = Crntb.parse_line('* * * 5-10 * foo.sh')
    assert_equal result, %Q{in May, June, July, August, September, October, on every day on every hour on every minute\n  run command "foo.sh"}

    result = Crntb.parse_line('* * * 5,10 * foo.sh')
    assert_equal result, %Q{in May, October, on every day on every hour on every minute\n  run command "foo.sh"}
  end

  def test_day_of_week_parse; end
end
