ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def raw_put(action, params, body)
    @request.env['RAW_POST_DATA'] = body
    response = put(action, params)
    @request.env.delete('RAW_POST_DATA')
    response
  end

end
