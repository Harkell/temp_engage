require 'test_helper'

class IntegrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get integrations_index_url
    assert_response :success
  end

  test "should get googlesheets" do
    get integrations_googlesheets_url
    assert_response :success
  end

end
