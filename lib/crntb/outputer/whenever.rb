module Crntb
  module Outputer
    module Whenever
      class << self
        def build(entry)
          <<EOS
every '#{entry.cron_definition}' do
  command "#{entry.command}"
end
EOS
        end
      end
    end
  end
end
