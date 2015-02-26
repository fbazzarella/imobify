require 'rails_helper'

RSpec.describe Admin::PhotosController, type: :controller do
  render_views

  describe 'POST #create' do
    context 'when logged in' do
      login!
  
      def post_create(params = {})
        post :create, {realty_id: realty.id, photo: [attributes_for(:photo)]}.merge!(params), format: :json
      end

      context 'when tenant is right' do
        let!(:realty) { create(:realty, account: @current_tenant) }

        before { post_create }

        it { expect(Photo.last.realty).to be_eql(realty) }

        it { expect(response.body).to match("\"id\":#{Photo.last.id}") }

        it { is_expected.to respond_with 200 }
      end

      context 'when tenant is wrong' do
        let!(:realty) { create(:realty) }

        it { expect{ post_create }.to raise_error(ActiveRecord::RecordNotFound) }
      end
    end

    context 'when logged out' do
      before { post :create, realty_id: 1, format: :json }

      it { should respond_with 401 }
    end
  end

  describe 'DELETE #destroy' do
    context 'when logged in' do
      login!

      context 'when tenant is right' do
        context 'when valid id' do
          let!(:realty) { create(:realty, account: @current_tenant) }
          let!(:photo)  { create(:photo, realty: realty) }

          before { delete :destroy, realty_id: photo.realty.id, id: photo.id, format: :json }

          it { expect(Photo.count).to be_zero }

          it { should respond_with 200 }
        end

        context 'when invalid id' do
          it { expect{ delete :destroy, realty_id: 1, id: 1, format: :json }.to raise_error(ActiveRecord::RecordNotFound) }
        end
      end

      context 'when tenant is wrong' do
        let!(:photo) { create(:photo) }

        it { expect{ delete :destroy, realty_id: photo.realty.id, id: photo.id, format: :json }.to raise_error(ActiveRecord::RecordNotFound) }
      end
    end

    context 'when logged out' do
      before { delete :destroy, realty_id: 1, id: 1, format: :json }

      it { should respond_with 401 }
    end
  end
end
