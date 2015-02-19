require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
 test "invalid signup information" do
   get signup_path
   assert_no_difference 'User.count' do
     post users_path, user: {name: "", email: "user@invalid", password: "foo", password_confirmation: "bar"}
   end
   assert_template 'users/new'
 end
 
 test "valid signup informatio" do
   get signup_path
   assert_difference 'User.count', 1 do
     post_via_redirect users_path, user: {name: "Cristina Mermeow", email: "cristina@mermeow.org", password_confirmation: "Wiwi123", password: "Wiwi123"}
   end
   assert_template 'users/show'
   assert_select "field_with_errors", "Welcome to the Sample App!"
 end
end
