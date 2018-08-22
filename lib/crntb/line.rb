module Crntb
  class Line
    def self.parse(line, formatter: :txt)
      return if line.empty?

      fields = Fields.new(line)
      Outputer::Text.build(fields)
    end
  end
end
