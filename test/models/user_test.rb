require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "user should always have email" do
    user = User.create(:email => "", :password => '1234', :password_confirmation => '1234')
    assert_not user.valid?
  end

  test "user can be created with just an email and password" do
    user = User.create(:email => "tests@getpokering.com", :password => '1234', :password_confirmation => '1234')
    assert user.valid?
  end

  test "no duplicate emails allowed" do
    user1 = User.create(:email => "tests@getpokering.com", :password => '1234', :password_confirmation => '1234')
    assert user1.valid?
    user2 = User.create(:email => "tests@getpokering.com", :password => '1234', :password_confirmation => '1234')
    assert_not user2.valid?
  end

  test "invalid email address not allowed" do
    user = User.create(:email => "12345", :password => '1234', :password_confirmation => '1234')
    assert_not user.valid?
  end

  test "set password (pin) encryption" do
    user = User.create(:email => "tests@getpokering.com", :password => '1234', :password_confirmation => '1234')
    assert_not user.password_digest.empty?
    assert_not_equal '1234', user.password_digest
  end

end
