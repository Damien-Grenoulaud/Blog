# frozen_string_literal: true

require 'test_helper'

class AuthenticationControllerTest < ActionDispatch::IntegrationTest
  test 'should get login' do
    get login_path

    assert_response :success
    assert_template :login
  end

  test 'should post login to search' do
    login

    assert_response :see_other
  end
  test 'should not post login to search' do
    post login_path params: {
        user: {
          mail: "test@test.com",
          password: "Faux mot de passe"
        }
    }
    

    assert_response :unprocessable_entity
    assert_template :login
  end
    

  test 'should logout' do
    login
    delete logout_path
    
    assert_response :redirect
  end


end
