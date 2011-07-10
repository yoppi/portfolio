class TwitterController < ApplicationController
  def index
    @statuses = Twitter.find_with(:screen_name => 'yoppiblog')
  end
end
