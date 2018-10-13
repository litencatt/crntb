module Crntb
  module Outputer
    module JSON
      class << self
        def build(entry)
          fields = entry.cron_definition.split(/\s/, 5)

          {
            "minute":       fields[0],
            "hour":         fields[1],
            "day_of_month": fields[2],
            "month":        fields[3],
            "day_of_week":  fields[4],
            "command":      entry.command
          }
        end
      end
    end
  end
end
