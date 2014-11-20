require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get signup" do
    get :new
    assert_select "title", "Sign up | Kinda like Twitter app"
    assert_response :success
  end

end
