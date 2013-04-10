class BlogController < ApplicationController
  def index
    @blog = Blog.find_by_user('yoppi')
  end
end
