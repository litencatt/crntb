module Crntb
  class Lines
    include Enumerable

    def initialize
      @lines = []
    end

    def <<(line)
      @lines << line
    end

    def each(&block)
      @lines.each(&block)
    end
  end
end
