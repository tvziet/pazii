require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'redirects to home page after successful register' do
    get register_path
    assert_response :ok

    assert_difference [ 'User.count', 'Organization.count' ], 1 do
      post register_path, params: {
        user: {
          name: 'Henry',
          email: 'henry@example.com',
          password: 'password'
        }
      }
    end

    assert_redirected_to root_path
    follow_redirect!
    assert_select '.notification.is-success',
      text: I18n.t('users.create.welcome', name: 'Henry')
  end

  test 'renders errors if input data is invalid' do
    get register_path
    assert_response :ok

    assert_no_difference [ 'User.count', 'Organization.count' ] do
      post register_path, params: {
        user: {
          name: 'Henry',
          email: 'henry@example.com',
          password: 'pass'
        }
      }
    end

    assert_response :unprocessable_entity
    assert_select 'p.is-danger',
      text: I18n.t('activerecord.errors.models.user.attributes.password.too_short')
  end
end
