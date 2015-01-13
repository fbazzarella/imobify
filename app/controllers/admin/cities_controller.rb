class Admin::CitiesController < Admin::AdminController
  skip_before_action :authenticate_admin_user!

  caches_page :index

  respond_to :json

  def index
    respond_with @cities = City.select(:id, :name).where(country_id: params[:country_id])
  end
end
