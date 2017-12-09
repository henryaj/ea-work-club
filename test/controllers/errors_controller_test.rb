require 'test_helper'

class ErrorsControllerTest < ActionDispatch::IntegrationTest
  test "should get internal_server_error" do
    get errors_internal_server_error_url
    assert_response :success
  end

end
