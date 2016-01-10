require 'test_helper'

class BuildsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get builds_show_url
    assert_response :success
  end

  test "should get new" do
    get builds_new_url
    assert_response :success
  end

end
