module Crntb
  class Field
    attr_reader :field

    class << self
      def parse(field)
        self.new(field).parse
      end
    end

    def initialize(field)
      @field = field
    end

    def parse
      #return nil unless valid?
      return '*' if first_to_last?
      interpretation
    end

    def shift(collections)
      collections
    end

    # 先頭文字列を処理
    #   */...
    #   n...
    #   それ以降はカンマ区切りでsplitして-はloop処理しての繰り返し
    def interpretation
      step_collections = field.split(',')
      collections = []
      step_collections.each do |step_collection|
        step = get_step(step_collection)
        if step[1] && step[1].match(/^[0-9]+$/)
          step_size = step[1].to_i
        else
          step_size = 1
        end

        # step[0] : *   => min..max
        # step[0] : n-m => n..m
        range = get_range(step[0])
        if range.length > 1
          s = range[0].to_i
          e = range[1].to_i
          s.step(e, step_size) { |r| collections << r }
        else
          collections << range[0].to_i
        end
      end
      collections.uniq.sort
      shift(collections)
      # 曜日や月は文字列にして追加
      # そうでなければ数字を追加
      result = collections.inject '' do |res, collection|
        res += collection.to_s
        res += ", "
      end
      result.slice!(result.size - 2, 2)
      result
    end

    def get_collection

    end

    # e.g
    #   "*/1"     => ["*", "1"]
    #   "*/1,2-4" => ["*", "1,2-4"]
    def get_range(value)
      if value == '*'
        [field_range.first, field_range.last]
      else
        value.split('-')
      end
    end

    def get_step(value)
      value.split('/')
    end

    def expand_range(collections)
      result = []
      collections.each do |collection|
        if collection.include?('-')
          min, max = collection.split('-', 2)
          for i in min..max do
            result << i
          end
        else
          result << collection
        end
      end
    end

    def first_to_last?
      field == '*'
    end

    def range_time?
    end

    def every_time?
    end

    private

    def have_asterisk?
      field.include?('*')
    end

    def have_hyphen?
      field.include?('-')
    end

    def have_slash?
      field.include?('/')
    end

    def have_comma?
      field.include?(',')
    end
  end

  class Minute < Field
    def field_range
      0..59
    end

    def parse
      case field
      when '*'
        "every minute"
      else
        "when minute equals #{super}"
      end
    end
  end

  class Hour < Field
    def parse
      case field
      when '*'
        "every hour "
      else
        "at #{super}"
      end
    end

    def field_range
      0..23
    end
  end

  class DayOfMonth < Field
    def parse
      case field
      when '*'
        ""
      else
        "on the #{super}"
      end
    end

    def field_range
      0..31
    end

    def shift(collections)
      collections.delete(0) if collections.include?(0)
    end
  end

  class Month < Field
    def parse
      case field
      when '*'
        "every day "
      else
        "In #{super}"
      end
    end

    def field_range
      0..12
    end

    def shift(collections)
      collections.delete(0) if collections.include?(0)
    end
  end

  class DayOfWeek < Field
    def parse
      case field
      when '*'
        ""
      else
        "and on #{super}"
      end
    end

    def field_range
      0..7
    end

    def shift(collections)
      collections.delete(0) if collections.include?(0)
    end
  end

  class Command < Field
    def parse
    end
  end
end
