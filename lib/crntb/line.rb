require 'crntb/outputer'
require 'json'

module Crntb
  class Line
    def initialize(line)
      return if line.empty?
      @entry = ::Crontab::Entry.parse(line)
    end

    def to_h
      Crntb::Outputer::Hash.build(@entry)
    end

    def to_json
      to_h.to_json
    end

    def to_chef
      Crntb::Outputer::ChefCron.build(@entry)
    end

    def to_whenever
      Crntb::Outputer::Whenever.build(@entry)
    end
  end
end
