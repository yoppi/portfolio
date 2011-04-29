class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :load_menu

private
  # TODO: generate from configuration file
  def load_menu
    @menus = %w[blog twitter github me]
  end
end
