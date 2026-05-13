require "test_helper"

class HealthCheckTest < ActionDispatch::IntegrationTest
  test "should work as expected" do
    get rails_health_check_url
    assert_response :success
  end
end
