require 'simplecov'
SimpleCov.start 'rails'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

require 'contexts'


class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #fixtures :all
  # Add more helper methods to be used by all tests here...
  include Contexts
  # Add more helper methods to be used by all tests here...

  # Add the infamous deny method...
  def deny(condition)
    # a simple transformation to increase readability IMO
    assert !condition
  end


end
