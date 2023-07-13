# frozen_string_literal: true

require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get articles_path

    assert_response :success
    assert_template :index
  end
end
