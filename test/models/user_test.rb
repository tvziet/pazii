# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string
#  name            :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:john)
    @user.password = 'password'
  end

  test 'requires a name' do
    @user.name = ''
    assert_not @user.valid?
  end

  test 'requires a valid email' do
    @user.email = ''
    assert_not @user.valid?

    @user.email = 'john$example.com'
    assert_not @user.valid?
  end

  test 'requires a unique email' do
    @duplicate_user = User.new(name: 'Test', email: @user.email.upcase)
    assert_not @duplicate_user.valid?
  end

  test 'name and email is stripped of spaces before saving' do
    @user.update(name: @user.name + ' ', email: @user.email + ' ')
    assert_equal 'John', @user.name
    assert_equal 'john@example.com', @user.email
  end

  test "password length must be between 8 and ActiveModel's maximum" do
    @user.password = '123123'
    assert_not @user.valid?

    max_length = ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED
    @user.password = 'a' * (max_length + 1)
    assert_not @user.valid?
  end

  test 'should authenticate user with correct password' do
    assert @user.authenticate('password')
  end

  test 'should not authenticate user with incorrect password' do
    assert_not @user.authenticate('wrongpassword')
  end
end
