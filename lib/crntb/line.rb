require 'crntb/outputer/hash'
require 'crntb/outputer/chef_cron'
require 'crntb/outputer/whenever'
require 'json'

module Crntb
  class Line
    def initialize(line)
      return if line.empty?
      @entry = ::Crontab::Entry.parse(line)
    end

    def to_h
      Outputer::Hash.build(@entry)
    end

    def to_json
      to_h.to_json
    end

    def to_chef
      Outputer::ChefCron.build(@entry)
    end

    def to_whenever
      Outputer::Whenever.build(@entry)
    end
  end
end
