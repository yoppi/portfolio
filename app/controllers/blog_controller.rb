require 'open-uri'
require 'hash'

class BlogController < ApplicationController

  HATEDA_RSS_URL = "http://d.hatena.ne.jp/yoppiblog/rss"

  def index
    @blog = HatenaDialyRSS.parse(HATEDA_RSS_URL)
  end

  class HatenaDialyRSS
    # FIXME: assert 'rss' is URL
    def self.parse(url)
      new(url)
    end

    def initialize(url)
      rss = open_rss(url)
      @channel = parse_channel(rss)
      @items = parse_items(rss)
    end
    attr_reader :channel, :items

    def open_rss(url)
      begin
        return Nokogiri::XML.parse(open(url))
      rescue => e
        # not yet
      end
    end

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
          :date => (item/'.//dc:date').inner_text,
        }
      end
    end
  end
end
