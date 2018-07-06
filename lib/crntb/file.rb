module Crntb
  class File
    def self.parse(file)
      ::File.readlines(file).each do |line|
        puts Crntb::Line.new(line).parse
      end
    end
  end
end
