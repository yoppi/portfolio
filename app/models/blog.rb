class HatenaBlogFeed
  FEED_URL = "http://%s.hatenablog.com/feed"

  def self.parse(user)
    new(FEED_URL % user)
  end

  def initialize(url)
    feed = open_feed(url)
    @root = parse_root(feed)
    @entries = parse_entry(feed)
  end
  attr_reader :root, :entries

  def open_feed(url)
    begin
      return Nokogiri::XML.parse(open(url))
    rescue => e
      # not yet
    end
  end

  def parse_root(feed)
    return {title: "", link: ""} unless feed
    {
      title: (feed/'title').first.text,
      link: (feed/'link').first.attr("href"),
    }
  end

  def parse_entry(feed)
    return [] unless feed
    (feed/'entry').inject([]) do |ret, entry|
      ret << {
        title: (entry/'title').text,
        link: (entry/'link').attr("href").value,
        summary: (entry/'summary').text,
        date: (entry/'published').text,
      }
    end
  end
end

class Blog < AbstractModel
  def self.find_by_user(user)
    ret = $redis.get(cache_key("find_by_user:#{user}"))
    return ActiveSupport::JSON.decode(ret) if ret
    ret = HatenaBlogFeed.parse(user)
    $redis.setex(cache_key("find_by_user:#{user}"), 360, ret.to_json)
    ret
  end
end
