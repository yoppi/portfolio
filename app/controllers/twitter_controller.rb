class TwitterController < ApplicationController
  def index
    @statuses = Twitter.find_by_user_id(:screen_name => 'yoppiblog')
  end
end
