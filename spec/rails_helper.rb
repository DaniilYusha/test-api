require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../config/environment', __dir__)
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'dox'
require 'rspec/rails'
require 'ffaker'

Dir[Rails.root.join('spec/docs/**/*.rb')].each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!

  config.after(:each, :dox) do |example|
    example.metadata[:request] = request
    example.metadata[:response] = response
  end

  config.filter_rails_from_backtrace!
end

Dox.configure do |config|
  # config.header_description = Rails.root.join('spec/docs/v1/descriptions/header.md').to_s
  # config.descriptions_location = Rails.root.join('spec/docs/v1/descriptions').to_s
  config.headers_whitelist = ['Accept', 'X-Auth-Token']
end
