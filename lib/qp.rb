require 'qp/file'
require 'qp/field'

class Qp
  def self.parse(file)
    Qp::File.new(file).parse
  end
end
