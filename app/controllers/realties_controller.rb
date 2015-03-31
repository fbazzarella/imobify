class RealtiesController < ApplicationController
  def index
    @search   = RealtySearch.new(params[:realty_search])
    @realties = @search.result.order(created_at: :desc)

    render_template
  end

  def show
    @realty = Realty.published.find_and_count(params[:id])

    render_template
  end
end
