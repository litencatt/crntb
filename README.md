Inspired by http://crontab.homecoded.com/

Convert crontab lines to other format.

### Install
```
$ git clone https://github.com/litencatt/crntb
$ cd /path/to/crntb
$ bundle install --path vendor/bundle
```

### Usage
Convert a line.
```rb
$ bin/console
[1] pry(main)> Crntb.parse("* * * * * foo.sh").to_h
=> "{\"minute\":\"*\",\"hour\":\"*\",\"day_of_month\":\"*\",\"month\":\"*\",\"day_of_week\":\"*\",\"command\":\"foo.sh\"}"

[1] pry(main)> Crntb.parse("* * * * * foo.sh").to_json
=> "{\"minute\":\"*\",\"hour\":\"*\",\"day_of_month\":\"*\",\"month\":\"*\",\"day_of_week\":\"*\",\"command\":\"foo.sh\"}"

[2] pry(main)> puts Crntb.parse("* * * * * foo.sh").to_chef
cron 'exec_foo.sh' do
  minute  "*"
  hour    "*"
  day     "*"
  month   "*"
  weekday "*"
  command "foo.sh"
end
=> nil

[3] pry(main)> puts Crntb.parse("* * * * * foo.sh").to_whenever
every '* * * * *' do
  command "foo.sh"
end
=> nil
```

Convert crontabs written in a file.
```rb
$ bin/console
[1] pry(main)> entries = Crntb.parse_file("./sample.cron")

[2] pry(main)> entries.map{|e| pp e.to_json}
=> ["{\"minute\":\"0\",\"hour\":\"8,10,12,14,16,18\",\"day_of_month\":\"*\",\"month\":\"*\",\"day_of_week\":\"*\",\"command\":\"php emptyTrash.php > log.txt\"}",
 "{\"minute\":\"1-6,9,32\",\"hour\":\"*\",\"day_of_month\":\"*\",\"month\":\"*\",\"day_of_week\":\"*\",\"command\":\"echo \\\"sample me good\\\" > /etc/tmp/trash.txt\"}",
 "{\"minute\":\"*\",\"hour\":\"4\",\"day_of_month\":\"*\",\"month\":\"*\",\"day_of_week\":\"*\",\"command\":\"/etc/init.d/apache2 restart\"}",
 "{\"minute\":\"*\",\"hour\":\"*\",\"day_of_month\":\"3-4\",\"month\":\"1,4,5\",\"day_of_week\":\"*\",\"command\":\"/etc/init.d/apache2 restart\"}",
 "{\"minute\":\"*\",\"hour\":\"*\",\"day_of_month\":\"3,5\",\"month\":\"12\",\"day_of_week\":\"1,5,6\",\"command\":\"/etc/init.d/apache2 restart\"}",
 "{\"minute\":\"10\",\"hour\":\"4\",\"day_of_month\":\"1\",\"month\":\"*\",\"day_of_week\":\"*\",\"command\":\"/root/scripts/backup.sh\"}",
 "{\"minute\":\"30\",\"hour\":\"3\",\"day_of_month\":\"*\",\"month\":\"*\",\"day_of_week\":\"mon\",\"command\":\"cat /proc/meminfo >> /tmp/meminfo\"}",
 "{\"minute\":\"*\",\"hour\":\"*\",\"day_of_month\":\"*\",\"month\":\"*\",\"day_of_week\":\"*\",\"command\":\"top > test.txt\"}"]
```
