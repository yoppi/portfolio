require 'open-uri'
require 'hash'

class BlogController < ApplicationController

  HATEDA_RSS_URL = "http://d.hatena.ne.jp/yoppiblog/rss"

  def index
    rss = open_rss(HATEDA_RSS_URL)
    @blog = HatenaDialyRSS.parse(rss)
  end

  def open_rss(rss_url)
    begin
      return Nokogiri::HTML.parse(open(rss_url))
    rescue => e
      # not yet
    end
  end

  class HatenaDialyRSS
    # FIXME: assert 'rss' is Nokogiri Object
    def self.parse(rss)
      new(rss)
    end

    def initialize(rss)
      @channel = parse_channel(rss)
      @items = parse_items(rss)
    end
    attr_reader :channel, :items

    def parse_channel(rss)
      return {:title => "", :link => ""} unless rss
      {
        :title => ((rss/'channel')/'title').inner_text,
        :link => ((rss/'channel')/'link').inner_text,
      }
    end

    def parse_items(rss)
      return [] unless rss
      (rss/'item').inject([]) do |ret, item|
        ret << {
          :title => (item/'title').inner_text,
          :link => (item/'link').inner_text,
          :description => (item/'description').inner_text,
          :date => (item/'date').inner_text,
        }
      end
    end
  end
end
