require 'rails_helper'

RSpec.describe Admin::PhotosController, type: :controller do
  render_views

  describe 'POST #create' do
    context 'when logged in' do
      login!
  
      def post_create(params = {})
        post :create, {realty_id: realty.id, photo: [attributes_for(:photo)]}.merge!(params)
      end

      let!(:realty) { create(:realty) }

      before { post_create }

      it { expect(Photo.count).to_not be_zero }

      it { expect(response.body).to match("\"id\":#{Photo.last.id}") }
      it { is_expected.to respond_with 200 }
    end

    context 'when logged out' do
      before { post :create, realty_id: 1 }

      it { expect(response).to redirect_to(new_admin_user_session_path) }
    end
  end
end
