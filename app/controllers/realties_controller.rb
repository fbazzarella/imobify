class RealtiesController < ApplicationController
  def index
    client_template_with @realties = Realty.published
  end
end
