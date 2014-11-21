require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "user should always have email" do
    user = User.create(:email => "")
    assert_not user.valid?
  end

  test "user can be created with just an email" do
    user = User.create(:email => "tests@getpokering.com")
    assert user.valid?
  end

  test "no duplicate emails allowed" do
    user1 = User.create(:email => "tests@getpokering.com")
    assert user1.valid?
    user2 = User.create(:email => "tests@getpokering.com")
    assert_not user2.valid?
  end

  test "invalid email address not allowed" do
    user = User.create(:email => "12345")
    assert_not user.valid?
  end

  test "set pin encryption" do
    user = User.create(:email => "tests@getpokering.com", :pin => '1234')
    assert_not user.pin_encrypted.empty?
    assert_not_equal '1234', user.pin_encrypted
  end

end
