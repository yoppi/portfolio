class ActivityController < ApplicationController
  def index
  end

  def test_double
    render(:layout => false,
           :file => "#{Rails.root}/public/slide/test_double.html")
  end
end
