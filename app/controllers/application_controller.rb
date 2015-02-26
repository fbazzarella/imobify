class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  responders :flash
  respond_to :html

  before_action :authenticate_staging!

  private

  def authenticate_staging!
    authenticate_or_request_with_http_basic do |u, p|
      u == ENV['APP_USER'] && p == ENV['APP_NAME']
    end if Rails.env.staging?
  end

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
