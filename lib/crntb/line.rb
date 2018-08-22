module Crntb
  class Line
    attr_reader :fields, :line

    def initialize(line)
      return if line.empty?

      @fields = Fields.new(line)
      @line = line
    end

    def to_s
      Outputer::Text.build(@fields)
    end

    def <=>(other)
      @fields.minute <=> other.fields.minute
    end
  end
end
