module Crntb
  class Line
    attr_reader :fields, :line

    def initialize(line)
      return if line.empty?

      @line = line
      @fields = Fields.new(line)
    end

    def to_s
      Outputer::Text.build(@fields)
    end

    def <=>(other)
      #if fields.day_of_week.to_i != 0
      #  fields.day_of_week <=> other.fields.day_of_week
      #elsif fields.month.to_i != 0
      #  fields.month <=> other.fields.month
      if fields.day_of_month.to_i != 0
        fields.day_of_month <=> other.fields.day_of_month
      elsif fields.hour.to_i != 0
        fields.hour <=> other.fields.hour
      else
        fields.minute <=> other.fields.minute
      end
    end
  end
end
