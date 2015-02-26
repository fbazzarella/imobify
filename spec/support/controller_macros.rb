module ControllerMacros
  def mapping!
    before do
      @request.env["devise.mapping"] = Devise.mappings[:admin_user]
      @current_admin_user = create(:user, account: @current_tenant)
    end
  end
  
  def login!
    mapping!
    
    before do
      sign_in @current_admin_user
    end
  end
end
