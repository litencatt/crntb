require 'crntb/file'
require 'crntb/line'
require 'crntb/field'
require 'crntb/outputer'

module Crntb
  def self.parse(file)
    ::File.readlines(file).map{ |line| Crntb::Line.parse(line.chomp!) }
  end

  def self.parse_line(line)
    Crntb::Line.parse(line)
  end
end
