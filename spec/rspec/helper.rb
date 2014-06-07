ENV["RAILS_ENV"] = "test"

require_relative "../../config/environment"
Rails.logger.level = 4
require "rspec/rails"

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = true
  config.include Rails.application.routes.url_helpers
  config.include Capybara::DSL
  config.order = "random"
end
