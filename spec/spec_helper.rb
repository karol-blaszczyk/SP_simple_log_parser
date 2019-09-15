# frozen_string_literal: true

Dir.glob(File.join('./lib', '**', '*.rb'), &method(:require))
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
    config.shared_context_metadata_behavior = :apply_to_host_groups
  end
end
