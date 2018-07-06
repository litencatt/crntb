module Crntb
  class Line

    def self.parse(line)
      fields = line.split(' ', 6)
      minute       = Minute.parse(fields[0])
      hour         = Hour.parse(fields[1])
      day_of_month = DayOfMonth.parse(fields[2])
      month        = Month.parse(fields[3])
      day_of_week  = DayOfWeek.parse(fields[4])

      command = fields[5].chomp

      [
        day_of_week,
        month,
        day_of_month,
        hour,
        minute,
        "run command #{command}"
      ].join(' ')
    end
  end
end
