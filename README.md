WIP project now.

### Usage
Passing crontab strings
```
Crntb.pase_line('* * * * * test.sh')
=> "every day   every hour every minute \n  exec test.sh"

Crntb.parse_line('*/10 * * * * test.sh')
=> "every day   every hour when minute equals 0, 10, 20, 30, 40, 50 \n  exec test.sh"
```

Passing text file
```
Crntb.parse('./sample.cron')
every day   every hour every minute
  exec sample.sh
```
