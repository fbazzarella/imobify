require 'rails_helper'

RSpec.describe Admin::RealtiesController, type: :controller do
  render_views

  describe 'GET #index' do
    context 'when logged in' do
      login!

      let!(:realty1) { create(:realty, account: @current_tenant) }
      let!(:realty2) { create(:realty) }

      before { get :index }

      it { expect(assigns(:realty)).to be_a_new(Realty) }
      it { expect(assigns(:realty).account).to be_eql(@current_tenant) }

      it { expect(assigns(:realties)).to be_a(ActiveRecord::Relation) }
      it { expect(assigns(:realties)).to include(realty1) }
      it { expect(assigns(:realties)).to_not include(realty2) }

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

      it { expect(Realty.first.account).to be_eql(@current_tenant) }

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

      context 'when tenant is right' do
        context 'when valid id' do
          let!(:realty) { create(:realty, account: @current_tenant) }

          before { get :edit, id: realty.id }

          it { expect(assigns(:realty)).to be_eql(realty) }

          it { is_expected.to respond_with 200 }
        end

        context 'when invalid id' do
          it { expect{ get :edit, id: 1 }.to raise_error(ActiveRecord::RecordNotFound) }
        end
      end

      context 'when tenant is wrong' do
        let!(:realty) { create(:realty) }

        it { expect{ get :edit, id: realty.id }.to raise_error(ActiveRecord::RecordNotFound) }
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

      context 'when tenant is right' do
        let!(:city)   { create(:city) }
        let!(:realty) { create(:realty, account: @current_tenant) }

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

      context 'when tenant is wrong' do
        let!(:realty) { create(:realty) }

        it { expect{ put_update(city_id: 1) }.to raise_error(ActiveRecord::RecordNotFound) }
      end
    end

    context 'when logged out' do
      before { put :update, id: 1 }

      it { expect(response).to redirect_to(new_admin_user_session_path) }
    end
  end

  describe 'PUT #publish' do
    context 'when logged in' do
      login!

      context 'when tenant is right' do
        context 'when valid id' do
          let!(:realty) { create(:realty, account: @current_tenant) }

          before do
            put :publish, realty_id: realty.id
            realty.reload
          end

          it { expect(realty).to be_published }

          it { should respond_with 302 }
        end

        context 'when invalid id' do
          it { expect{ put :publish, realty_id: 1, format: :json }.to raise_error(ActiveRecord::RecordNotFound) }
        end
      end

      context 'when tenant is wrong' do
        let!(:realty) { create(:realty) }

        it { expect{ put :publish, realty_id: realty.id }.to raise_error(ActiveRecord::RecordNotFound) }
      end
    end

    context 'when logged out' do
      before { put :publish, realty_id: 1 }

      it { expect(response).to redirect_to(new_admin_user_session_path) }
    end
  end

  describe 'PUT #deactivate' do
    context 'when logged in' do
      login!

      context 'when tenant is right' do
        context 'when valid id' do
          let!(:realty) { create(:realty, account: @current_tenant) }

          before do
            put :deactivate, realty_id: realty.id
            realty.reload
          end

          it { expect(realty).to be_deactivated }

          it { should respond_with 302 }
        end

        context 'when invalid id' do
          it { expect{ put :deactivate, realty_id: 1, format: :json }.to raise_error(ActiveRecord::RecordNotFound) }
        end
      end

      context 'when tenant is wrong' do
        let!(:realty) { create(:realty) }

        it { expect{ put :deactivate, realty_id: realty.id }.to raise_error(ActiveRecord::RecordNotFound) }
      end
    end

    context 'when logged out' do
      before { put :deactivate, realty_id: 1 }

      it { expect(response).to redirect_to(new_admin_user_session_path) }
    end
  end
end
