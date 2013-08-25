class HatenaBlogFeed
  FEED_URL = "http://%s.hatenablog.com/feed"
  attr_reader :root, :articles

  def self.parse(user)
    new(FEED_URL % user)
  end

  def initialize(url)
    feed = open_feed(url)
    @root = parse_root(feed)
    @articles = parse_article(feed)
  end

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

  def parse_article(feed)
    return [] unless feed
    (feed/'entry').inject([]) do |ret, article|
      ret << {
        title: (article/'title').text,
        link: (article/'link').attr("href").value,
        summary: (article/'summary').text,
        date: (article/'published').text,
      }
    end
  end
end

class Blog
  include Redisable
  redis_key :entries

  def self.find_by_user(user)
    ret = redis.get entries(user)
    return JSON.parse(ret) if ret
    ret = HatenaBlogFeed.parse(user)
    redis.setex entries(user), 360, ret.to_json
    ret
  end
end
