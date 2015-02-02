class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  responders :flash
  respond_to :html

  private

  def render_theme
    theme = 'zoner'

    render(
      template: "#{theme}/#{controller_name}/#{action_name}",
      layout:   "#{theme}/application"
    )
  end
end
