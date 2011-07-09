class TwitterFinder

  USER_TIMELINE_API = "https://api.twitter.com/%s/statuses/user_timeline.%s?%s"
  VERSION = 1
  FORMATS = %w[json xml rss atom]
  PARAMS = [
    :user_id,
    :screen_name,
    :since_id,
    :max_id,
    :count,
    :page,
    :trim_user,
    :include_rts,
    :include_entities,
  ]

  def find_by_user_id(options)
    Nokogiri::XML.parse(open(create_api(options)))
  end

  def create_api(options)
    version = options.has_key?(':version') ? options.version : VERSION
    format = options.has_key?(':format') ? options.format : 'xml'
    params = create_parasm(options)
    USER_TIMELINE_API % [version, format, params.join('?')]
  end

  def create_parasm(options)
    options.inject([]) do |ret, (k, v)|
      ret << "#{k}=#{v}" if PARAMS.include? k
      ret
    end
  end
end

class Twitter
  attr_reader :created_at, :id, :text, :source, :user
  @@finder = ::TwitterFinder.new

  def self.find_by_user_id(options)
    statuses = @@finder.find_by_user_id(options)
    (statuses/'status').inject([]) do |ret, timeline|
      ret << new(timeline)
    end
  end

  def initialize(status)
    parse_status(status)
  end

  def parse_status(status)
    @created_at = (status/'./created_at').inner_text
    @id = (status/'./id').inner_text
    @text = (status/'text').inner_text
    @source = (status/'source').inner_text
    @user = {
      :id => (status/'user/id').inner_text,
      :name => (status/'user/name').inner_text,
      :screen_name => (status/'user/screen_name').inner_text,
      :profile_image_url => (status/'user/profile_image_url').inner_text
    }
  end
end

