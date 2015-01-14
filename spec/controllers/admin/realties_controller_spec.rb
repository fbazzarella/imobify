require 'rails_helper'

RSpec.describe Admin::RealtiesController, type: :controller do
  render_views

  describe 'GET #index' do
    context 'when logged in' do
      login!

      let!(:realty) { create(:realty) }

      before { get :index }

      it { expect(assigns(:realty)).to be_a(Realty) }
      it { expect(assigns(:realty).country).to be_eql(realty.country) }

      it { expect(assigns(:locations)).to be_a(Hash) }
      it { expect(assigns(:locations).keys).to include(:countries, :cities) }

      it { expect(assigns(:realties)).to be_a(ActiveRecord::Relation) }
      it { expect(assigns(:realties)).to include(realty) }

      it { is_expected.to respond_with 200 }

      context 'when none realty exists' do
        before do
          Realty.destroy_all
          get :index
        end

        it { expect(assigns(:realty)).to be_a_new(Realty) }
        it { expect(assigns(:realty).country).to be_nil }
      end
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

      let!(:country) { create(:country) }
      let!(:city) { create(:city, country: country) }

      before { post_create(country_id: country.id, city_id: city.id) }

      it { expect(Realty.count).to_not be_zero }
      it { should respond_with 302 }
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

        it { expect(assigns(:locations)).to be_a(Hash) }
        it { expect(assigns(:locations).keys).to include(:countries, :cities) }

        it { should respond_with 200 }
      end

      context 'when invalid id' do
        it { expect{ get :edit, id: 1 }.to raise_error(ActiveRecord::RecordNotFound) }
      end
    end

    context 'when logged out' do
      before { get :edit, id: 1 }

      it { expect(response).to redirect_to(new_admin_user_session_path) }
    end
  end
end
