class RealtiesController < ApplicationController
  def index
    @search   = RealtySearch.new(params[:realty_search])
    @realties = @search.result.order(created_at: :desc)

    render_theme
  end
end
