require 'rails_helper'

RSpec.describe RealtiesController, type: :controller do
  render_views

  describe 'GET #index' do
    mapping!

    let!(:realty1) { create(:realty, status: 'published', rooms: 1, account: @current_tenant) }
    let!(:realty2) { create(:realty, status: 'published', rooms: 2, account: @current_tenant) }
    let!(:realty3) { create(:realty, status: 'published', rooms: 1) }

    before { get :index, realty_search: {rooms: 1} }

    it { expect(assigns(:search)).to be_a(RealtySearch) }
    it { expect(assigns(:search).rooms).to be_eql('1') }

    it { expect(assigns(:realties)).to be_a(ActiveRecord::Relation) }
    it { expect(assigns(:realties)).to include(realty1) }
    it { expect(assigns(:realties)).to_not include(realty2, realty3) }

    it { is_expected.to respond_with 200 }
  end

  describe 'GET #show' do
    context 'when tenant is right' do
      let!(:realty1) { create(:realty, status: 'published', account: @current_tenant) }
      let!(:realty2) { create(:realty, account: @current_tenant) }

      context 'when valid id' do
        before { get :show, id: realty1.id }

        it { expect(assigns(:realty)).to be_eql(realty1) }

        it { is_expected.to respond_with 200 }
      end

      context 'when invalid id' do
        it { expect{ get :show, id: realty2.id }.to raise_error(ActiveRecord::RecordNotFound) }
      end
    end

    context 'when tenant is wrong' do
      let!(:realty) { create(:realty) }

      it { expect{ get :show, id: realty.id }.to raise_error(ActiveRecord::RecordNotFound) }
    end
  end
end
