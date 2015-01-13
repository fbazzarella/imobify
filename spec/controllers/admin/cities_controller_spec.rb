require 'rails_helper'

RSpec.describe Admin::CitiesController, type: :controller do
  render_views

  describe 'GET #index' do
    let!(:country) { create(:country) }
    let!(:city) { create(:city, country: country) }

    before { get :index, country_id: country.id, format: :json }

    it { expect(assigns(:cities)).to be_a(ActiveRecord::Relation) }
    it { expect(assigns(:cities)).to include(city) }

    it { expect(response.body).to match("\"id\":#{city.id}") }
    it { is_expected.to respond_with 200 }
  end
end
