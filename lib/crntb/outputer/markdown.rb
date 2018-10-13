module Crntb
  module Outputer
    module Markdown
      class << self
        def build(entry, translated)
          fields = entry.cron_definition.split(/\s/, 5)

          <<~RUBY
            ## Summary
            #{translated}

            ### Command
            ```
            #{entry.command}
            ```
            ### Fields

            | fields | minute | hour |day_of_month | month | day_of_week |
            | --- | --- | --- | --- | --- | --- |
            | value | #{fields[0]}  | #{fields[1]} | #{fields[2]} | #{fields[3]} | #{fields[4]} |
          RUBY
        end
      end
    end
  end
end
