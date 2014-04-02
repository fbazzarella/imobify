require 'spec_helper'

describe UsersController do
  render_views

  describe 'GET #index' do
    context 'when logged in' do
      login!

      before { get :index }

      it { should respond_with 200 }
    end

    context 'when logged out' do
      before { get :index }

      it { expect(response).to redirect_to(new_user_session_path) }
    end
  end
end
