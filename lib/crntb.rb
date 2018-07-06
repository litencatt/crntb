require 'crntb/file'
require 'crntb/line'
require 'crntb/field'

module Crntb
  def self.parse(file)
    Crntb::File.parse(file)
  end

  def self.parse_line(line)
    Crntb::Line.new(line).parse
  end
end
