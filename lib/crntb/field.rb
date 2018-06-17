module Crntb
  class Field
    attr_reader :field, :collections

    class << self
      def parse(field)
        self.new(field).parse
      end
    end

    def initialize(field)
      @field = field
      @collections = []
    end

    def parse
      #return nil unless valid?
      return '*' if first_to_last?
      interpretation
    end

    def interpretation
      step_collections.each do |step_collection|
        step  = get_step(step_collection)
        range = get_range(step[0])
        add_collections(step, range)
      end
      collections.uniq.sort
      shift_collections
      result = collections.inject '' do |res, collection|
        res += translate_of(collection)
        res += ", "
      end
      result.slice!(result.size - 2, 2)
      result
    end

    def translate_of(collection)
      collection.to_s
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

    def add_collections(step, range)
      if range.length > 1
        s = range[0].to_i
        e = range[1].to_i
        s.step(e, step_size(step)) { |r| collections << r }
      else
        collections << range[0].to_i
      end
    end

    def step_size(step)
      if step[1] && step[1].match(/^[0-9]+$/)
        step[1].to_i
      else
        1
      end
    end

    def shift_collections
      collections
    end

    def first_to_last?
      field == '*'
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
    def parse
      case field
      when '*'
        "every minute"
      else
        "when minute equals #{super}"
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

    def shift_collections
      collections.delete(0) if collections.include?(0)
    end
  end

  class Month < Field
    LOOKUP_NAMES = %w(
      Voidember
      January
      February
      March
      April
      May
      June
      July
      August
      September
      October
      November
      December
    )

    MAP_NAMES = %w(
      voi
      jan
      feb
      mar
      apr
      may
      jun
      jul
      aug
      sep
      oct
      nov
      dec
    )

    def parse
      case field
      when '*'
        "every day"
      else
        "In #{super}"
      end
    end

    def field_range
      0..12
    end

    def shift_collections
      collections.delete(0) if collections.include?(0)
    end

    def translate_of(collection)
      LOOKUP_NAMES[collection]
    end
  end

  class DayOfWeek < Field
    LOOKUP_NAMES = %w(
      Voidday
      Mondays
      Tuesdays
      Wednesdays
      Thursdays
      Fridays
      Saturdays
      Sundays
    )

    MAP_NAMES = %w(
      voi
      mon
      tue
      wed
      thu
      fri
      sat
      sun
    )

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

    def shift_collections
      collections.delete(0) if collections.include?(0)
    end

    def translate_of(collection)
      LOOKUP_NAMES[collection]
    end
  end
end
