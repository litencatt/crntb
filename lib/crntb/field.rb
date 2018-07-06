module Crntb
  class Field
    attr_reader :field, :collections
    SEPARATOR = ', '.freeze

    def self.parse(field)
      self.new(field).parse
    end

    def initialize(field)
      @field = field
      @collections = []
    end

    def interpretation
      return nil if step_collections.size == 0

      step_collections.each do |step_collection|
        step  = get_step(step_collection)
        range = get_range(step[0])
        add_collections(step, range)
      end
      collections.compact! # remove nil element
      collections.uniq.sort
      result = collections.inject '' do |res, collection|
        res += translation_of(collection) + SEPARATOR
      end
      result.slice!(result.size - 2, 2)

      result
    end

    def step_collections
      field.split(',')
    end

    def get_step(value)
      value.split('/')
    end

    def get_range(value)
      if value == '*'
        [field_range.first, field_range.last]
      else
        value.split('-')
      end
    end

    # mon -> 1にして追加
    def add_collections(step, range)
      if range.length > 1
        s = lookupValue(range[0])
        e = lookupValue(range[1])
        s.step(e, step_size(step)) { |r| collections << r }
      else
        collections << lookupValue(range[0])
      end
    end

    def step_size(step)
      if step[1] && step[1].match(/^[0-9]+$/)
        step[1].to_i
      else
        1
      end
    end

    def lookupValue(range)
      if map_defined? && !number?(range.to_s)
        map_find_by_key(range)
      else
        range.to_i
      end
    end

    def number?(s)
      s.match(/^\d+$/)
    end

    def translation_of(collection)
      if map_defined?
        map_values(collection)
      else
        collection.to_s
      end
    end

    def map_defined?
      self.class.const_defined?(:MAP_NAMES)
    end

    def map_find_by_key(key)
      self.class::MAP_NAMES.keys.index(key)
    end

    def map_values(collection)
      self.class::MAP_NAMES.values[collection]
    end
  end

  class Minute < Field
    def parse
      case field
      when '*'
        "every minute"
      else
        interpretation
      end
    end

    def field_range
      0..59
    end
  end

  class Hour < Field
    def parse
      case field
      when '*'
        "every hour"
      else
        interpretation
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
        "*"
      else
        interpretation
      end
    end

    def field_range
      1..31
    end
  end

  class Month < Field
    MAP_NAMES = {
      'voi' => 'Voidember',
      'jan' => 'January',
      'feb' => 'February',
      'mar' => 'March',
      'apr' => 'April',
      'may' => 'May',
      'jun' => 'June',
      'jul' => 'July',
      'aug' => 'August',
      'sep' => 'September',
      'oct' => 'October',
      'nov' => 'November',
      'dec' => 'December',
    }

    def parse
      case field
      when '*'
        "*"
      else
        interpretation
      end
    end

    def field_range
      1..12
    end

    def translate_of(collection)
      LOOKUP_NAMES[collection]
    end
  end

  class DayOfWeek < Field
    MAP_NAMES = {
      'voi' => 'Voidday',
      'mon' => 'Mondays',
      'tue' => 'Tuesdays',
      'wed' => 'Wednesdays',
      'thu' => 'Thursdays',
      'fri' => 'Fridays',
      'sat' => 'Saturdays',
      'sun' => 'Sundays',
    }

    def parse
      case field
      when '*'
        "*"
      else
        interpretation
      end
    end

    def field_range
      1..7
    end

    def translate_of(collection)
      LOOKUP_NAMES[collection]
    end
  end
end
