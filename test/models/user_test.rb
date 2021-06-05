require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'user email invalid' do
    user = User.new(email: 'test', password: '000')
    assert_not user.valid?
  end
  test 'user email already taken' do
    some_user = users(:one)
    user = User.new(email: some_user.email, password: '000')
    assert_not user.valid?
  end
  test 'user valid' do
    user = User.new(email: 'testValid@test.com', password: '000')
    assert user.valid?
  end
end
