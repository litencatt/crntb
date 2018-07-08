module Crntb
  class Line
    def self.parse(line)
      fields = Fields.new(line)
      result = Outputer::Text.build(fields)
      %Q{#{result}\n  run command "#{fields.command}"}
    end
  end
end
