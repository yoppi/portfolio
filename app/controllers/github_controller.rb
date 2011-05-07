class GithubController < ApplicationController
  def index
    @activities = Github.find_by_user('yoppi')
  end
end
