# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    Article.destroy_all
    @article = Article.create title: "title"
    @comment = Comment.create(article: @article)
  end

  test 'should get index' do
    get article_comments_path(@article)
    
    assert_response :success
    assert_template :index
  end

  test 'should create comment' do
    post article_comments_path @article, params: {
      comment: {
        commenter: "",
        body: ""
      }
    }

    assert_response :see_other
    assert Comment.count == 2
  end

  test "shouldn't destroy comment if not connected" do
    delete article_comment_path @article, @comment

    assert_response :unauthorized
  end

  test "should destroy comment if connected" do
    delete article_comment_path(@article, @comment), headers: http_login

    assert_response :see_other
    assert Comment.find_by(id: @comment.id).nil?
  end

  private

  def http_login
   {"Authorization": ActionController::HttpAuthentication::Basic.encode_credentials("dhh","secret")}
   end
end

