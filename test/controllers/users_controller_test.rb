require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  def setup
    @user = users(:ricardo)
    @other_user = users(:wiwi)
  end
  
  test "should get signup" do
    get :new
    assert_select "title", "Sign up | Kinda like Twitter app"
    assert_response :success
  end
  
  test "should redirect edit when not logged in" do
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect update when not logged in" do
    patch :update, id: @user, user: {name: @user.name, email: @user.email }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect edit when logged in as different user" do
    log_in_as(@other_user)
    get :edit, id: @user
    assert flash.empty?
    assert_redirected_to root_url
    
  end
  
  test "should redirect update when logged in as different user" do
    log_in_as(@user)
    patch :update, id: @other_user, user: { name: @other_user.name, email: @other_user.email}
    assert flash.empty?
    assert_redirected_to root_url
    
  end
  
  test "should redirect to login url when visiting index" do
    get :index
    assert_redirected_to login_url
  end
  
  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to login_url
  end
  
  test "should redirect destroy when logged in as non admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to root_url
  end

end
