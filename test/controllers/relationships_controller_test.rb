require 'test_helper'

class RelationshipsControllerTest < ActionController::TestCase
  test "should require logged in user to create" do
    assert_no_difference 'Relationship.count' do
      post :create
    end
    assert_redirected_to login_url
  end
  
  test "should require logged in user to destroy" do
    assert_no_difference 'Relationship.count' do
      delete :destroy, id: relationships(:two)
    end
  end
end
