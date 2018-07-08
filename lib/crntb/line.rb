module Crntb
  class Line
    def self.parse(line)
      fields = Fields.new(line)

      result = ''
      if fields.month != '*'
        result += "in #{fields.month}, on "
      end
      if fields.month == '*' and fields.day_of_month != '*'
        result += "every month on "
      end
      if fields.day_of_month == '*'
        if fields.day_of_week == '*'
          result += 'every day '
        end
      else
        result += "the "
        days = fields.day_of_month.split(',')
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
      if fields.day_of_week != '*'
        result += 'and on ' if fields.day_of_month != '*'
        result += fields.day_of_week + ' '
      end

      hour_collections = fields.hour.split(',')
      min_collections = fields.minute.split(',')
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
          result += "on #{fields.minute} when hour is ("
          hour_collections.each do |hour_collection|
            result += "%#02d" % hour_collection + ', '
          end
          result.slice!(result.size - 2, 2)
          result += ')'
        end
      else
        # input exp. ["every hour"]
        if min_collections.length > 1
          result += "on #{fields.hour} when minute equals one of ("
          min_collections.each do |min_collection|
            result += "%#02d" % min_collection + ', '
          end
          result.slice!(result.size - 2, 2)
          result += ')'
        else
          if fields.hour.to_i.to_s == fields.hour and fields.minute.to_i.to_s == fields.minute
            result += "on #{fields.hour}:#{fields.minute}"
          elsif fields.minute.to_i.to_s == fields.minute
            result += "on #{fields.hour} when minute equals " + "%#02d" % fields.minute
          else
            result += "on #{fields.hour} on #{fields.minute}"
          end
        end
      end

      %Q{#{result}\n  run command "#{fields.command}"}
    end
  end
end
