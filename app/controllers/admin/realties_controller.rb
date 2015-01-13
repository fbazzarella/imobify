class Admin::RealtiesController < Admin::AdminController
  def index
    locations_for @realty   = Realty.last.dup
    respond_with  @realties = Realty.all
  end

  private

  def locations_for(realty)
    @locations = Country.all_with_cities_by(realty.country)
  end
end
