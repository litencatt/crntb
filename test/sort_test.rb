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

  def test_sort_hour
    setup_lines [
      '2 1 * * * test.sh',
      '1 3 * * * test.sh',
      '3 2 * * * test.sh',
    ]

    assert_equal @lines.sort.map(&:line), [
      '2 1 * * * test.sh',
      '3 2 * * * test.sh',
      '1 3 * * * test.sh',
    ]
  end

  def test_sort_dom
    setup_lines [
      '2 1 3 * * test.sh',
      '1 3 1 * * test.sh',
      '3 2 2 * * test.sh',
    ]

    assert_equal @lines.sort.map(&:line), [
      '1 3 1 * * test.sh',
      '3 2 2 * * test.sh',
      '2 1 3 * * test.sh',
    ]
  end

#  def test_sort_month
#    setup_lines [
#      '2 1 3 3 * test.sh',
#      '1 3 1 2 * test.sh',
#      '3 2 2 1 * test.sh',
#    ]
#
#    assert_equal @lines.sort.map(&:line), [
#      '3 2 2 1 * test.sh',
#      '1 3 1 2 * test.sh',
#      '2 1 3 3 * test.sh',
#    ]
#  end

#  def test_sort_dow
#    setup_lines [
#      '2 1 3 * 1 test.sh',
#      '1 3 1 * 3 test.sh',
#      '3 2 2 * 2 test.sh',
#    ]
#
#    assert_equal @lines.sort.map(&:line), [
#      '2 1 3 * 1 test.sh',
#      '3 2 2 * 2 test.sh',
#      '1 3 1 * 3 test.sh',
#    ]
#  end
end
