# frozen_string_literal: true

class ArticlesController < ApplicationController

  def index
    puts params[:titleSearch]
    if params[:titleSearch].present?
        @articles = Article.all.where "title like '%#{params[:titleSearch]}%'"
    else
        @articles = Article.all
    end
    puts @articles.count
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end
end
