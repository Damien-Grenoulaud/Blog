# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_article

  def index
    @comments = Comment.includes([:user]).where(article: @article)
  end

  def create
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article), status: :see_other
  end

  def destroy
    @comment = @article.comments.find(params[:id])
    if @comment.deletable?
      @comment.destroy
      redirect_to article_path(@article), status: :see_other
    else
      render article_path(@article), status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end
end
