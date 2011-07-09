class GithubActivity

  ACTIVITY_URL = "https://github.com/%s.atom"

  def find_by_user(user)
    Nokogiri::XML.parse(open(create_api(user)))
  end

  def create_api(user)
    ACTIVITY_URL % user
  end
end

class Github
  attr_reader :id, :published, :title, :author, :content
  @@github_activity = GithubActivity.new

  def self.find_by_user(user)
    activities = @@github_activity.find_by_user(user)
    (activities/'entry').inject([]) do |ret, activity|
      ret << new(activity)
      ret
    end
  end

  def initialize(activity)
    parse_activity(activity)
  end

  def parse_activity(activity)
    @id = (activity/'id').inner_text
    @published = (activity/'published').inner_text
    @title = (activity/'title').inner_text
    @author = {
      :name => (activity/'author/name').inner_text,
      :uri => (activity/'author/uri').inner_text
    }
    @content = (activity/'content').inner_text.delete("\n")
  end
end
