require 'rails_helper'

RSpec.describe Admin::SessionsController, type: :controller do
  render_views

  
  context 'when sign in' do
    mapping!

    before { post :create, admin_user: {username: 'johndoe', password: 'secret'} }

    it { is_expected.to redirect_to(admin_root_path) }
  end

  context 'when sign out' do
    login!
  
    before { delete :destroy }

    it { is_expected.to redirect_to(new_admin_user_session_path) }
  end
end
