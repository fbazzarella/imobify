class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  responders :flash
  respond_to :html

  before_filter lambda {
    authenticate_or_request_with_http_basic { |u, p|
      u == ENV['APP_USER'] && p == ENV['APP_NAME'] } if Rails.env.staging? }

  private

  def render_theme
    theme = arminda? ? 'zoner_arminda' : 'zoner'

    render(
      template: "#{theme}/#{controller_name}/#{action_name}",
      layout:   "#{theme}/application"
    )
  end

  def arminda?
    !!request.host.match(/armindabaptista/)
  end
end
