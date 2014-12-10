require 'rails_helper'

RSpec.describe Admin::RealtiesController, type: :controller do
  render_views

  describe 'GET #index' do
    context 'when logged in' do
      login!

      let!(:realty) { create(:realty) }

      before { get :index }

      it { expect(assigns(:realties)).to be_a(ActiveRecord::Relation) }
      it { expect(assigns(:realties)).to include(realty) }
      it { is_expected.to respond_with 200 }
    end

    context 'when logged out' do
      before { get :index }

      it { is_expected.to redirect_to(new_admin_user_session_path) }
    end
  end
end
