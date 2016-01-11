ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'rr'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

module JSONTestHelper
  def get_json(path)
    get(path, params: {}, header: { "ACCEPT" => "application/json" })
  end

  def post_json(path, object:)
    post(path, params: {}, env: { 'RAW_POST_DATA' => object.to_json }, headers: { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json" })
  end

  def put_json(path, object:)
    put(path, params: {}, env: { 'RAW_POST_DATA' => object.to_json}, headers: { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json" })
  end

  def response_json
    JSON.parse(response.body, symbolize_names: true)
  end
end

