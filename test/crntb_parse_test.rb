require 'test_helper'

class FileParseTest < Minitest::Test
  def test_parse_file
    parsed_crontab = [
      %Q{every day at 08:00, 10:00, 12:00, 14:00, 16:00, 18:00\n  run command "php emptyTrash.php > log.txt"},
      %Q{every day on every hour when minute equals one of (01, 02, 03, 04, 05, 06, 09, 32)\n  run command "echo "sample me good" > /etc/tmp/trash.txt"},
      %Q{every day on every minute when hour is (04)\n  run command "/etc/init.d/apache2 restart"},
      %Q{in January, April, May, on the 3rd, 4th on every hour on every minute\n  run command "/etc/init.d/apache2 restart"},
      %Q{in December, on the 3rd, 5th and on Mondays, Fridays, Saturdays on every hour on every minute\n  run command "/etc/init.d/apache2 restart"},
      %Q{every month on the 1st at 04:10\n  run command "/root/scripts/backup.sh"},
      %Q{Mondays at 03:30\n  run command "cat /proc/meminfo >> /tmp/meminfo"},
      %Q{every day on every hour on every minute\n  run command "top > test.txt"},
    ]
    result = Crntb.parse_file('./sample.cron').map(&:to_s)
    assert_equal result, parsed_crontab
  end
end
