# frozen_string_literal: true

require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test "Creation titre mauvais" do
    @article = Article.new(title: "test")
    assert_not @article.save,"test"
  end

  test "Creation titre bon" do
    @article = Article.new(title: "test bon")
    assert @article.save,"test bon"
  end
  # test "the truth" do
  #   assert true
  # end
end
