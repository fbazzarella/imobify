class RealtiesController < ApplicationController
  def index
    client_template_with @realties = Realty.order('created_at DESC')
  end
end
