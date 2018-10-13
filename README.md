Inspired by http://crontab.homecoded.com/

Convert crontab lines to other format.

## Install
```
$ git clone https://github.com/litencatt/crntb
$ cd /path/to/crntb
$ bundle install --path vendor/bundle
```

## Usage
Convert a line.

### Hash
`.to_h`
```rb
$ bin/console
[1] pry(main)> Crntb.parse("* * * * * foo.sh").to_h
=> {:minute=>"*", :hour=>"*", :day_of_month=>"*", :month=>"*", :day_of_week=>"*", :command=>"foo.sh"}
```

### JSON
`.to_json`
```
[1] pry(main)> Crntb.parse("* * * * * foo.sh").to_json
=> "{\"minute\":\"*\",\"hour\":\"*\",\"day_of_month\":\"*\",\"month\":\"*\",\"day_of_week\":\"*\",\"command\":\"foo.sh\"}"

```

### To Chef cron resource DSL
`to_chef`
```
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
```

### To Whenever DSL
`.to_whenever`
```
[3] pry(main)> puts Crntb.parse("* * * * * foo.sh").to_whenever
every '* * * * *' do
  command "foo.sh"
end
=> nil
```

### To English
`.to_eng`
```
[2] pry(main)> Crntb.parse("* * * * * foo.sh").to_eng
=> "every minute of every hour of every day, Execute \"foo.sh\""
```

### To Markdown
`.to_md`
```
[3] pry(main)> Crntb.parse("* * * * * foo.sh").to_md
=> "## Summary\nevery minute of every hour of every day, Execute \"foo.sh\"\n\n### Command\n```\nfoo.sh\n```\n### Fields\n\n| fields | minute | hour |day_of_month | month | day_of_week |\n| --- | :---: | :---: | :---: | :---: | :---: |\n| value | *  | * | * | * | * |\n"
```

---

## Summary
every minute of every hour of every day, Execute "foo.sh"

### Command
```
foo.sh
```
### Fields

| fields | minute | hour |day_of_month | month | day_of_week |
| --- | :---: | :---: | :---: | :---: | :---: |
| value | *  | * | * | * | * |

---

### Convert crontabs written in a file.
```rb
$ bin/console
[1] pry(main)> Crntb.parse_file("./sample.cron").map{|e| pp e.to_json }
```
