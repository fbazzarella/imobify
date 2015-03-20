class Admin::PhotosController < Admin::AdminController
  def create
    render json: realty.photos.create(file: params[:photo].first).to_json
  end

  def destroy
    render json: realty.photos.destroy(params[:id]).to_json
  end

  private

  def realty
    Realty.find(params[:realty_id])
  end
end
