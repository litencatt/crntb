require 'crntb/line'
require 'crntb/lines'
require 'crntb/field'
require 'crntb/outputer'

module Crntb
  def self.parse(line)
    Crntb::Line.new(line)
  end

  def self.parse_file(file)
    ::File.readlines(file).inject(Crntb::Lines.new) do |lines, line|
      lines << Crntb::Line.new(line.chomp!)
    end
  end

  def self.sort(file)
    parse_file(file).sort.map(&:line)
  end
end
