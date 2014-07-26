ENV["RAILS_ENV"] ||= "test"

require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'

Dir[File.expand_path('../support/*', __FILE__)].each { |f| require f }

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include Devise::TestHelpers, type: :controller
  config.extend  ControllerMacros,    type: :controller

  config.infer_spec_type_from_file_location!
  config.raise_errors_for_deprecations!

  config.use_transactional_fixtures = true
  config.color = true
end
