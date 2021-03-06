require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name:"Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end
  
  test "should be valid" do
    assert @user.valid?
  end
  
  test "name should be present" do
    @user.name = "      "
    assert_not @user.valid?
  end
  
  test "email should be present" do
    @user.email = "       "
    assert_not @user.valid?
  end
  
  test "name shouldn't be too long" do
    @user.name = "r" * 51
    assert_not @user.valid?
  end
  
  test "email shouldn't be too long" do
    @user.email = "r" * 244 + "@example.com"
    assert_not @user.valid?
  end
  
  test "should validate valid email adresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |address|
      @user.email = address
      assert @user.valid?, "#{address.inspect} should be valid"
    end
  end
  
  test "should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |address|
      @user.email = address
      assert_not @user.valid?, "#{address.inspect} should be invalid"
    end
    
  end
  
  test "should reject duplicate email_addresses" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "password should be at leat 6 chars long" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
  
  test "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "This a test!")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end
  
  test "should follow and unfollow a user" do
    ricardo = users(:ricardo)
    cristina = users(:cristina)
    assert_not ricardo.following?(cristina)
    ricardo.follow(cristina)
    assert ricardo.following?(cristina)
    assert cristina.followers.include?(ricardo)
    ricardo.unfollow(cristina)
    assert_not ricardo.following?(cristina)
  end
  
  test "should show own microposts and from followed users not others" do
    ricardo = users(:ricardo)
    cristina = users(:cristina)
    wiwi = users(:wiwi)
    
    #ver mis posts 
    ricardo.microposts.each do |micropost|
      assert ricardo.feed.include?(micropost)
    end
    #ver post de wiwi 
    wiwi.microposts.each do |micropost|
      assert ricardo.feed.include?(micropost)
    end
    #pero no los de la mermeow
    cristina.microposts.each do |micropost|
      assert_not ricardo.feed.include?(micropost)
    end
  end
end
