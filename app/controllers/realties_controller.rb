class RealtiesController < ApplicationController
  def index
    @realties = Realty.published

    render_theme
  end
end
