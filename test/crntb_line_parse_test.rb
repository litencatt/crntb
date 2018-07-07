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

  def test_day_of_week_parse
    result = Crntb.parse_line('* * * * 3   foo.sh')
    assert_equal result, %Q{Wednesdays on every hour on every minute\n  run command "foo.sh"}

    result = Crntb.parse_line('* * * * */3 foo.sh')
    assert_equal result, %Q{Mondays, Thursdays, Sundays on every hour on every minute\n  run command "foo.sh"}

    result = Crntb.parse_line('* * * * 1-3 foo.sh')
    assert_equal result, %Q{Mondays, Tuesdays, Wednesdays on every hour on every minute\n  run command "foo.sh"}

    result = Crntb.parse_line('* * * * 1,3 foo.sh')
    assert_equal result, %Q{Mondays, Wednesdays on every hour on every minute\n  run command "foo.sh"}
  end

  def test_mix_parse
    result = Crntb.parse_line('0 8,10,12,14,16,18 * * * php emptyTrash.php > log.txt')
    assert_equal result, %Q{every day at 08:00, 10:00, 12:00, 14:00, 16:00, 18:00\n  run command "php emptyTrash.php > log.txt"}

    result = Crntb.parse_line('1-6,9,32 * * * * echo "sample me good" > /etc/tmp/trash.txt')
    assert_equal result, %Q{every day on every hour when minute equals one of (01, 02, 03, 04, 05, 06, 09, 32)\n  run command "echo "sample me good" > /etc/tmp/trash.txt"}

    result = Crntb.parse_line('* 4 * * * /etc/init.d/apache2 restart')
    assert_equal result, %Q{every day on every minute when hour is (04)\n  run command "/etc/init.d/apache2 restart"}

    result = Crntb.parse_line('* * 3-4 1,4,5 * /etc/init.d/apache2 restart')
    assert_equal result, %Q{in January, April, May, on the 3rd, 4th on every hour on every minute\n  run command "/etc/init.d/apache2 restart"}

    result = Crntb.parse_line('* * 3,5 12 1,5,6 /etc/init.d/apache2 restart')
    assert_equal result, %Q{in December, on the 3rd, 5th and on Mondays, Fridays, Saturdays on every hour on every minute\n  run command "/etc/init.d/apache2 restart"}

    result = Crntb.parse_line('10 4 1 * * /root/scripts/backup.sh')
    assert_equal result, %Q{every month on the 1st at 04:10\n  run command "/root/scripts/backup.sh"}

    result = Crntb.parse_line('30 3 * * mon cat /proc/meminfo >> /tmp/meminfo')
    assert_equal result, %Q{Mondays at 03:30\n  run command "cat /proc/meminfo >> /tmp/meminfo"}

    result = Crntb.parse_line('* * * * * top > test.txt')
    assert_equal result, %Q{every day on every hour on every minute\n  run command "top > test.txt"}
  end
end
