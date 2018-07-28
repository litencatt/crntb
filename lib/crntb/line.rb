module Crntb
  class Line
    def self.parse(line, formatter: :txt)
      fields = Fields.new(line)
      Outputer::Text.build(fields)
    end
  end
end
