require 'qp/file'
require 'qp/field'

class Qp
  def self.parse(file)
    Qp::File.parse(file)
  end

  def self.parse_line(line)
    Qp::Line.new(line).parse
  end
end
