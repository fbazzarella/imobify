class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  responders :flash
  respond_to :html

  set_current_tenant_through_filter

  before_action :authenticate_staging!, :set_tenant!

  private

  def authenticate_staging!
    authenticate_or_request_with_http_basic do |u, p|
      u == ENV['APP_USER'] && p == ENV['APP_NAME']
    end if Rails.env.staging?
  end

  def set_tenant!
    set_current_tenant Account.by_host(request.host)
  end

  def render_theme
    template = "#{current_tenant.theme}/#{controller_name}/#{action_name}"
    layout   = "#{current_tenant.theme}/application"

    render template: template, layout: layout
  end
end
