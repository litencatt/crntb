class Qp
  class Field
    class << self
      def parse(field)
        self.new(field).parse
      end
    end

    def initialize(field)
      @field = field
    end

    def parse
      field.digits
      field.have_asterisk?
      field.have_hyphen?
      field.have_slash?
      field.have_comma?
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
    def parse
      super
      case @field
      when '*'
        "every minute"
      else
        @field.to_s
      end
    end

    def validate
      0..59
    end
  end

  class Hour < Field
    def self.parse(field)
    end

    def validate
      0..23
    end
  end

  class DayOfMonth < Field
    def self.parse(field)
    end

    def validate
      1..31
    end
  end

  class Month < Field
    def self.parse(field)
    end

    def validate
      1..12
    end
  end

  class DayOfWeek < Field
    def self.parse(field)
    end

    def validate
      0..7
    end
  end
  class Command < Field
    def self.parse(field)
    end
  end
end
