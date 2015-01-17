require 'rails_helper'

RSpec.describe Admin::RealtiesController, type: :controller do
  render_views

  describe 'GET #index' do
    context 'when logged in' do
      login!

      let!(:realty) { create(:realty) }

      before { get :index }

      it { expect(assigns(:realty)).to be_a_new(Realty) }

      it { expect(assigns(:realties)).to be_a(ActiveRecord::Relation) }
      it { expect(assigns(:realties)).to include(realty) }

      it { is_expected.to respond_with 200 }
    end

    context 'when logged out' do
      before { get :index }

      it { is_expected.to redirect_to(new_admin_user_session_path) }
    end
  end

  describe 'POST #create' do
    context 'when logged in' do
      login!
  
      def post_create(params = {})
        post :create, realty: attributes_for(:realty).merge!(params)
      end

      let!(:city) { create(:city) }

      before { post_create(country_id: city.country.id, city_id: city.id) }

      it { expect(Realty.count).to_not be_zero }

      it { is_expected.to respond_with 302 }
    end

    context 'when logged out' do
      before { post :create }

      it { expect(response).to redirect_to(new_admin_user_session_path) }
    end
  end

  describe 'GET #edit' do
    context 'when logged in' do
      login!

      context 'when valid id' do
        let!(:realty) { create(:realty) }

        before { get :edit, id: realty.id }

        it { expect(assigns(:realty)).to be_eql(realty) }

        it { is_expected.to respond_with 200 }
      end
    end

    context 'when logged out' do
      before { get :edit, id: 1 }

      it { expect(response).to redirect_to(new_admin_user_session_path) }
    end
  end

  describe 'PUT #update' do
    context 'when logged in' do
      login!

      def put_update(params = {})
        put :update, id: realty.id, realty: attributes_for(:realty).merge!(params)
        realty.reload
      end

      let!(:city)   { create(:city) }
      let!(:realty) { create(:realty) }

      context 'when valid attributes' do
        before { put_update(country_id: city.country.id, city_id: city.id) }

        it { expect(realty.country).to be_eql(city.country) }
        it { expect(realty.city).to    be_eql(city) }

        it { is_expected.to respond_with 302 }
      end

      context 'when invalid attributes' do
        before { put_update(business_kind: 'other') }

        it { expect(realty.business_kind).to be_nil }

        it { is_expected.to respond_with 200 }
      end
    end

    context 'when logged out' do
      before { put :update, id: 1 }

      it { expect(response).to redirect_to(new_admin_user_session_path) }
    end
  end
end
