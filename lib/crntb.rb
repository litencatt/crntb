require 'crntb/file'
require 'crntb/line'
require 'crntb/field'
require 'crntb/outputer'

module Crntb
  def self.parse(line)
    Crntb::Line.new(line)
  end

  def self.parse_file(file)
    ::File.readlines(file).map{ |line| Crntb::Line.new(line.chomp!).to_s }
  end
end
