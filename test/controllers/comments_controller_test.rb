# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test 'should create new' do
    comments_count = Comment.count
    @article = Article.create("Nouvel Article")
    post article_comment_path(@article, params: {
      comment: {
        commenter: "new commenter",
        body: "new body"
      }
    })

    assert_response :redirect, "reussi create new"
    assert Comment.count == comments_count + 1
  end
end
