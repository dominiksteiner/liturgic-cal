ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

require 'database_cleaner/active_record'

DatabaseCleaner.strategy = :truncation

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    setup do
      DatabaseCleaner.clean
    end

    # Add more helper methods to be used by all tests here...
  end
end
