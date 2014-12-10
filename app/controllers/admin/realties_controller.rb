class Admin::RealtiesController < Admin::AdminController
  def index
    respond_with @realties = Realty.all
  end
end
