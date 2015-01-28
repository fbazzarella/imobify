class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  responders :flash
  respond_to :html

  private

  def client_template_with(_)
    namespace = 'zoner'

    template = "#{namespace}/#{controller_name}/#{action_name}"
    layout   = "#{namespace}/application"
    
    render template: template, layout: layout
  end
end
