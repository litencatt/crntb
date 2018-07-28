Inspired by http://crontab.homecoded.com/

Translate crontab lines to human readable.

### Usage
Pass crontab string
```rb
[1] pry(main)> Crntb.parse('* * * * * test.sh')
=> "every day on every hour on every minute\n  run command \"test.sh\""

[2] pry(main)> Crntb.parse('*/10 * * * * test.sh')
=> "every day on every hour when minute equals one of (00, 10, 20, 30, 40, 50)\n  run command \"test.sh\""
```

Pass text file
```rb
[1] pry(main)> Crntb.parse_file('./sample.cron')
=> ["every day at 08:00, 10:00, 12:00, 14:00, 16:00, 18:00\n  run command \"php emptyTrash.php > log.txt\"",
 "every day on every hour when minute equals one of (01, 02, 03, 04, 05, 06, 09, 32)\n  run command \"echo \"sample me good\" > /etc/tmp/trash.txt\"",
 "every day on every minute when hour is (04)\n  run command \"/etc/init.d/apache2 restart\"",
 "in January, April, May, on the 3rd, 4th on every hour on every minute\n  run command \"/etc/init.d/apache2 restart\"",
 "in December, on the 3rd, 5th and on Mondays, Fridays, Saturdays on every hour on every minute\n  run command \"/etc/init.d/apache2 restart\"",
 "every month on the 1st at 04:10\n  run command \"/root/scripts/backup.sh\"",
 "Mondays at 03:30\n  run command \"cat /proc/meminfo >> /tmp/meminfo\"",
 "every day on every hour on every minute\n  run command \"top > test.txt\""]
```
