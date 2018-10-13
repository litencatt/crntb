module Crntb
  module Outputer
    module ChefCron
      class << self
        def build(entry)
          fields = entry.cron_definition.split(/\s/, 5)

          <<EOS
cron 'exec_#{entry.command}' do
  minute  "#{fields[0]}"
  hour    "#{fields[1]}"
  day     "#{fields[2]}"
  month   "#{fields[3]}"
  weekday "#{fields[4]}"
  command "#{entry.command}"
end
EOS
        end
      end
    end
  end
end
