ENV["RAILS_ENV"] ||= "test"

require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'

Dir[File.expand_path('../support/*', __FILE__)].each { |f| require f }

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include Devise::TestHelpers, type: :controller
  config.extend  ControllerMacros,    type: :controller

  config.use_transactional_fixtures = true
  config.color = true

  config.before(:each) do
    @current_tenant = create(:account, {
      site_settings: create(:site_setting),
      domains:      [create(:domain, host: 'test.host')]
    })
  end

  config.after(:each) do
    ActsAsTenant.current_tenant = nil
  end

  config.after(:suite) do
    FileUtils.rm_rf(Dir["#{Rails.root}/tmp/uploads"])
  end
end
