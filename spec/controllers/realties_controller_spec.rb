require 'rails_helper'

RSpec.describe RealtiesController, type: :controller do
  render_views

  describe 'GET #index' do
    let!(:realty1) { create(:realty, status: 'published', rooms: 1) }
    let!(:realty2) { create(:realty) }

    before { get :index, realty_search: {rooms: 1} }

    it { expect(assigns(:search)).to be_a(RealtySearch) }
    it { expect(assigns(:search).rooms).to be_eql('1') }

    it { expect(assigns(:realties)).to be_a(ActiveRecord::Relation) }
    it { expect(assigns(:realties)).to include(realty1) }
    it { expect(assigns(:realties)).to_not include(realty2) }

    it { is_expected.to respond_with 200 }
  end
end
