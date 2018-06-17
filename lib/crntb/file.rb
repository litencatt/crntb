module Crntb
  class File
    def self.parse(file)
      ::File.readlines(file).each do |line|
        Crntb::Line.new(line).parse
      end
    end
  end

  class Line
    attr_reader :minute, :hour, :day_of_month, :month, :day_of_week, :command

    def initialize(line)
        fields = manipuate(line)
        @minute       = Minute.parse(fields[0])
        @hour         = Hour.parse(fields[1])
        @day_of_month = DayOfMonth.parse(fields[2])
        @month        = Month.parse(fields[3])
        @day_of_week  = DayOfWeek.parse(fields[4])
        @command      = fields[5].chomp
    end

    def parse
      [
        month,
        day_of_week,
        day_of_month,
        hour,
        minute,
        "\n  exec #{@command}",
      ].join(" ")
    end

    def manipuate(line)
      line.split(' ', 6)
    end
  end
end
