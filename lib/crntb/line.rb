require 'crntb/outputer/json'
require 'crntb/outputer/chef_cron'
require 'crntb/outputer/whenever'

module Crntb
  class Line
    def initialize(line)
      return if line.empty?
      @entry = ::Crontab::Entry.parse(line)
    end

    def to_json
      Outputer::JSON.build(@entry)
    end

    def to_chef
      Outputer::ChefCron.build(@entry)
    end

    def to_whenever
      Outputer::Whenever.build(@entry)
    end
  end
end
