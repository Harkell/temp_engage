require 'test_helper'

class InternalControllerTest < ActionDispatch::IntegrationTest
  test "should get control" do
    get internal_control_url
    assert_response :success
  end

end
