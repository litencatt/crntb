class Qp
  class File
    attr_reader :minute, :hour, :day_of_month, :month, :day_of_week, :command

    def initialize(file)
      ::File.readlines(file).each do |line|
        fields = manipuate(line)
        @minute       = Minute.parse(fields[0])
        @hour         = Hour.parse(fields[1])
        @day_of_month = DayOfWeek.parse(fields[2])
        @month        = Month.parse(fields[3])
        @day_of_week  = DayOfMonth.parse(fields[4])
        @command      = Command.parse(fields[5].chomp)
      end
    end

    def parse
      "#{@minute} #{@hour} #{@day_of_month} #{@month} #{@day_of_week} #{@command}"
    end

    def manipuate(line)
      line.split(' ', 6)
    end
  end
end
