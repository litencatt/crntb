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

      result = ''
      if month != '*'
        result += "in #{month}, on "
      end
      if month == '*' and day_of_month != '*'
        result += "every month on "
      end
      if day_of_month == '*'
        if day_of_week == '*'
          result += 'every day '
        end
      else
        result += "the "
        days = day_of_month.split(',')
        days.each do |day|
          case day.to_i
          when 1
            result += "#{day}st,"
          when 2
            result += "#{day}nd,"
          when 3
            result += "#{day}rd,"
          else
            result += "#{day}th,"
          end
        end
        result.slice!(result.size - 1, 1)
        result += ' '
      end
      if day_of_week != '*'
        result += 'and on ' if day_of_month != '*'
        result += day_of_week + ' '
      end

      hour_collections = hour.split(',')
      min_collections = minute.split(',')
      if hour_collections.length > 1 or hour_collections[0].to_i.to_s == hour_collections[0]
        # input exp. ["1,2"]
        if min_collections.length > 1 or min_collections[0].to_i.to_s == min_collections[0]
          result += 'at '
          hour_collections.each do |hour_collection|
            min_collections.each do |min_collection|
              result += "%#02d" % hour_collection + ':' + "%#02d" % min_collections + ', '
            end
          end
          result.slice!(result.size - 2, 2)
        else
          result += "on #{minute} when hour is ("
          hour_collections.each do |hour_collection|
            result += "%#02d" % hour_collection + ', '
          end
          result.slice!(result.size - 2, 2)
          result += ')'
        end
      else
        # input exp. ["every hour"]
        if min_collections.length > 1
          result += "on #{hour} when minute equals one of ("
          min_collections.each do |min_collection|
            result += "%#02d" % min_collection + ', '
          end
          result.slice!(result.size - 2, 2)
          result += ')'
        else
          if hour.to_i.to_s == hour and minute.to_i.to_s == minute
            result += "on #{hour}:#{minute}"
          elsif minute.to_i.to_s == minute
            result += "on #{hour} when minute equals " + "%#02d" % minute
          else
            result += "on #{hour} on #{minute}"
          end
        end
      end

      "#{result}\n  run command #{command}"
    end
  end
end
