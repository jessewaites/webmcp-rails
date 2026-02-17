# frozen_string_literal: true

require "active_support/all"
require "action_view"
require "webmcp-rails"

# Manually prepend since we're not in a Rails app
ActionView::Helpers::FormHelper.prepend(Webmcp::FormHelper)

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
