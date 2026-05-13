require "test_helper"

class SignInTest < ActionDispatch::IntegrationTest
  test "should work as expected" do
    get new_session_url
    assert_dom "h2", "Sign in"

    post session_url, params: {
      email_address: "one@gmail.com",
      password: "password"
    }

    2.times { follow_redirect! }
    assert_dom "h2", "Test plans list"
  end
end
