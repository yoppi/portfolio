class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :load_menu

private
  # TODO: generate from configuration file
  def load_menu
    @menus = %w[home activity]
  end
end
