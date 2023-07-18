# frozen_string_literal: true

require 'test_helper'

class AuthenticationControllerTest < ActionDispatch::IntegrationTest
  test 'should get login' do
    get login_path

    assert_response :success
    assert_template :login
  end

end
