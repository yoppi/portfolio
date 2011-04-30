module ApplicationHelper
  def current_controller?(name)
    controller.controller_name == name
  end
end
