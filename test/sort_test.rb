require 'test_helper'

class SortTest < Minitest::Test
  def setup
    @lines = Crntb::Lines.new
  end

  def setup_lines(cases)
    cases.each do |line|
      @lines << Crntb::Line.new(line)
    end
  end

  def test_sort_minute
    setup_lines [
      '1 * * * * test.sh',
      '0 * * * * test.sh',
      '2 * * * * test.sh',
    ]

    assert_equal @lines.sort.map(&:line), [
      '0 * * * * test.sh',
      '1 * * * * test.sh',
      '2 * * * * test.sh',
    ]
  end
end
