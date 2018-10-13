require 'crntb/line'
require 'crntb/field'
require 'crontab'

module Crntb
  def self.parse(line)
    Crntb::Line.new(line)
  end

  def self.parse_file(file)
    ::File.readlines(file).each_with_object([]) do |line, arr|
      arr << Crntb::Line.new(line.chomp!)
    end
  end
end
