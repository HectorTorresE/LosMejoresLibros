require "test_helper"

class SalesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get sales_create_url
    assert_response :success
  end
end
