module Crntb
  module Outputer
    module Text
      class << self
        attr_reader :result, :fields

        def build(fields)
          @result = ''
          @fields = fields

          day_week_month_result
          min_hour_result

          @result
        end

        def day_week_month_result
          build_month
          build_day_of_month
          build_day_of_week
        end

        def build_month
          @result += "in #{fields.month}, on " if fields.month != '*'
          @result += "every month on " if fields.month == '*' and fields.day_of_month != '*'
        end

        def build_day_of_month
          if fields.day_of_month == '*'
            @result += 'every day ' if fields.day_of_week == '*'
          else
            @result += 'the '
            days = fields.day_of_month.split(',')
            days.each do |day|
              case day.to_i
              when 1
                @result += "#{day}st,"
              when 2
                @result += "#{day}nd,"
              when 3
                @result += "#{day}rd,"
              else
                @result += "#{day}th,"
              end
            end
            @result.slice!(@result.size - 1, 1)
            @result += ' '
          end
        end

        def build_day_of_week
          if fields.day_of_week != '*'
            @result += 'and on ' if fields.day_of_month != '*'
            @result += fields.day_of_week + ' '
          end
        end

        def min_hour_result
          hour_collections = fields.hour.split(',')
          min_collections = fields.minute.split(',')
          if hour_collections.length > 1 or hour_collections[0].to_i.to_s == hour_collections[0]
            # input exp. ["1,2"]
            if min_collections.length > 1 or min_collections[0].to_i.to_s == min_collections[0]
              @result += 'at '
              hour_collections.each do |hour_collection|
                min_collections.each do |min_collection|
                  @result += "%#02d" % hour_collection + ':' + "%#02d" % min_collections + ', '
                end
              end
              @result.slice!(@result.size - 2, 2)
            else
              @result += "on #{fields.minute} when hour is ("
              hour_collections.each do |hour_collection|
                @result += "%#02d" % hour_collection + ', '
              end
              @result.slice!(@result.size - 2, 2)
              @result += ')'
            end
          else
            # input exp. ["every hour"]
            if min_collections.length > 1
              @result += "on #{fields.hour} when minute equals one of ("
              min_collections.each do |min_collection|
                @result += "%#02d" % min_collection + ', '
              end
              @result.slice!(@result.size - 2, 2)
              @result += ')'
            else
              if fields.hour.to_i.to_s == fields.hour and fields.minute.to_i.to_s == fields.minute
                @result += "on #{fields.hour}:#{fields.minute}"
              elsif fields.minute.to_i.to_s == fields.minute
                @result += "on #{fields.hour} when minute equals " + "%#02d" % fields.minute
              else
                @result += "on #{fields.hour} on #{fields.minute}"
              end
            end
          end
        end
      end
    end
  end
end
