module ApplicationHelper
  def menu_link_to(text, url = '/', options = {})
    css_class = 'active' if Rails.application.routes.recognize_path(url, options[:data] || {})[:controller] == params[:controller]
    content_tag :li, link_to(text, url, options), class: css_class
  end

  def cover_path_for(realty)
    realty.cover_url || image_path('admin/no_cover_bg.png')
  end
end
