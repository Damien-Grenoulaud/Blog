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

  test 'should create new' do
    get new_article_path(:action=>"create",:title=>"test ok")

    assert_response :success,"reussi create new"
    assert_template :new,"chemin create new"
  end
  test 'should get edit' do
    @article = Article.create(title: "nouvel article")
    get edit_article_path(id: @article.id)

    assert_response :success,"Acces au edit"
    assert_template :edit,"Acces au edit"
  end

  test 'should update edit' do
    @article = Article.create(title: "nouvel article")
    get edit_article_path(action: "update",id: @article.id,title: "nouveau titre")

    assert_response :success,"reussi au update"
    assert_template :edit,"chemin au update"
    assert @article.title = "nouveau titre"
  end
  
end
