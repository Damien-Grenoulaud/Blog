# frozen_string_literal: true

require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get articles_path

    assert_response :success
    assert_template :index
  end

  test 'should get new' do
    get new_article_path

    assert_response :success,"Acces au new"
    assert_template :new,"Acces au new"
  end
end
