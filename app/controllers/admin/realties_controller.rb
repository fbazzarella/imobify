class Admin::RealtiesController < Admin::AdminController
  def index
    locations_for @realty   = last_or_new_realty
    respond_with  @realties = Realty.all
  end

  private

  def locations_for(realty)
    @locations = Country.all_with_cities_by(realty.country)
  end

  def last_or_new_realty
    Realty.last.try(:dup) || Realty.new
  end
end
