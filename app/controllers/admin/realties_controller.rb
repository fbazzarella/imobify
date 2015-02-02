class Admin::RealtiesController < Admin::AdminController
  def index
    @realty   = Realty.new_with_last_locations
    @realties = Realty.order(created_at: :desc)

    respond_with
  end

  def create
    respond_with @realty = Realty.create(realty_params), location: edit_admin_realty_path(@realty)
  end

  def edit
    respond_with @realty = Realty.find(params[:id])
  end

  def update
    respond_with @realty = Realty.update(params[:id], realty_params), location: admin_realties_path
  end

  def publish
    respond_with @realty = Realty.find(params[:realty_id]).publish!, location: admin_realties_path
  end

  def deactivate
    respond_with @realty = Realty.find(params[:realty_id]).deactivate!, location: admin_realties_path
  end

  private

  def realty_params
    params.require(:realty).permit(*Realty::PERMITTED_FIELDS)
  end
end
