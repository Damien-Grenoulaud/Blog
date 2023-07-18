# frozen_string_literal: true

require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get articles_path

    assert_response :success
    assert_template :index
  end

  test 'should get new' do
    connect_user()
    get new_article_path

    assert_response :success,"Acces au new"
    assert_template :new,"Acces au new"
  end

  test 'should not get new' do
    get new_article_path

    assert_response :redirect,"Acces au new"
  end

  test 'should create new' do
    connect_user()

    article_count = Article.count
    post articles_path params: {
      article: {
        title: "new title",
        text: "new text"
      }
    }

    assert_response :redirect, "reussi create new"
    assert Article.count == article_count + 1
  end

  test 'should not create new' do
    article_count = Article.count
    post articles_path params: {
      article: {
        title: "new title",
        text: "new text"
      }
    }

    assert_response :redirect, "non reussi create new"
    assert Article.count == article_count
  end
  
  test 'should get edit' do
    connect_user()

    @article = Article.create(title: "nouvel article")
    get edit_article_path(id: @article.id)

    assert_response :success,"Acces au edit"
    assert_template :edit,"Acces au edit"
  end

  test 'should not get edit' do
    @article = Article.create(title: "nouvel article")
    get edit_article_path(id: @article.id)

    assert_response :redirect,"Acces au edit"
  end


  test 'should update edit' do
    connect_user()

    @article = Article.create(title: "nouvel article")
    
    patch article_path(@article, params: {
      article: {
        title: "new title"
      }
      
    })
    assert_response :redirect,"reussi au update"

    assert Article.find(@article.id).title == "new title"
  end

  test 'should not update edit' do
    @article = Article.create(title: "nouvel article")
    
    patch article_path(@article, params: {
      article: {
        title: "new title"
      }
      
    })
    assert_response :redirect,"non reussi au update"

    assert Article.find(@article.id).title == "nouvel article"
  end

  test 'should destroy article' do
    connect_user()

    @article = Article.create(title: "nouvel article")
    
    delete article_path(@article)
    assert_response :redirect,"reussi au delete"

    assert_not Article.find_by id:@article.id
  end


  test 'should not destroy article' do
    @article = Article.create(title: "nouvel article")
    
    delete article_path(@article)
    assert_response :redirect,"non reussi au delete"

    assert Article.find_by id:@article.id
  end
  
  def connect_user
    @user = User.find_by(mail: "jacques@test.com").try(:authenticate, "motdepasse")
    session[:current_user_id] = @user.id
    getCurrentUser
  end
end
