module Crntb
  class Line
    def initialize(line)
      return if line.empty?

      @fields = Fields.new(line)
    end

    def to_s
      Outputer::Text.build(@fields)
    end
  end
end
