class HatenaDialyRSS

  HATEDA_RSS_URL = "http://d.hatena.ne.jp/%s/rss"

  def self.parse(user)
    new(HATEDA_RSS_URL % user)
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

class Blog < AbstractModel
  def self.find_by_user(user)
    ret = $redis.get(cache_key("find_by_user:#{user}"))
    return ActiveSupport::JSON.decode(ret) if ret
    ret = HatenaDialyRSS.parse(user)
    $redis.set(cache_key("find_by_user:#{user}"), ret.to_json)
    return ret
  end
end
