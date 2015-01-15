class Admin::RealtiesController < Admin::AdminController
  def index
    locations_for @realty   = last_or_new_realty
    respond_with  @realties = Realty.all
  end

  def create
    respond_with @realty = Realty.create(realty_params), location: edit_admin_realty_path(@realty.id || 0)
  end

  def edit
    respond_with locations_for(@realty = Realty.find(params[:id]))
  end

  def update
    respond_with locations_for(@realty = Realty.update(params[:id], realty_params)), location: admin_realties_path
  end

  private

  def locations_for(realty)
    @locations = Country.all_with_cities_by(realty.country)
    realty
  end

  def last_or_new_realty
    Realty.last.try(:dup) || Realty.new
  end

  def realty_params
    params.require(:realty).permit(
      :country_id, :city_id, :neighborhood, :street,
      :business_kind, :realty_kind, :reference,
      :rooms, :bathrooms, :parking_spaces, :size,
      :price, :taxes, :description, :published)
  end
end
