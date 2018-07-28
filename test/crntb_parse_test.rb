require 'test_helper'

class FileParseTest < Minitest::Test
  def test_parse_file
    result = Crntb.parse_file('./sample.cron')
    assert_includes result, %Q{every day at 08:00, 10:00, 12:00, 14:00, 16:00, 18:00\n  run command "php emptyTrash.php > log.txt"}
    assert_includes result, %Q{every day on every hour when minute equals one of (01, 02, 03, 04, 05, 06, 09, 32)\n  run command "echo "sample me good" > /etc/tmp/trash.txt"}
    assert_includes result, %Q{every day on every minute when hour is (04)\n  run command "/etc/init.d/apache2 restart"}
    assert_includes result, %Q{in January, April, May, on the 3rd, 4th on every hour on every minute\n  run command "/etc/init.d/apache2 restart"}
    assert_includes result, %Q{in December, on the 3rd, 5th and on Mondays, Fridays, Saturdays on every hour on every minute\n  run command "/etc/init.d/apache2 restart"}
    assert_includes result, %Q{every month on the 1st at 04:10\n  run command "/root/scripts/backup.sh"}
    assert_includes result, %Q{Mondays at 03:30\n  run command "cat /proc/meminfo >> /tmp/meminfo"}
    assert_includes result, %Q{every day on every hour on every minute\n  run command "top > test.txt"}
  end
end
