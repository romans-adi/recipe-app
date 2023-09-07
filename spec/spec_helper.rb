require 'capybara/rspec'
require 'selenium-webdriver'

Capybara.register_driver :selenium_firefox do |app|
  options = Selenium::WebDriver::Firefox::Options.new
  options.headless!
  options.args << '--disable-gpu'
  Capybara::Selenium::Driver.new(app, browser: :firefox, options:)
end

Capybara.javascript_driver = :selenium_firefox

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  Capybara.javascript_driver = :selenium_chrome
  Capybara.server_host = '127.0.0.1'
  Capybara.server_port = 35_015

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
