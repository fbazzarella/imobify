require 'spec_helper'

describe Devise::SessionsController do
  render_views
  
  login!

  before { delete :destroy }

  it { expect(response).to redirect_to(new_user_session_path) }
end
