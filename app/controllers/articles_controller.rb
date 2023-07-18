# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :login_relocate_obligatory, except: [:index, :show]
  before_action :set_article, except: [:index,:create]

  def index
    if params[:titleSearch].present?
        @articles = Article.all.where "title like '%#{params[:titleSearch]}%'"
    else
        @articles = Article.all
    end
  end

  def show; end

  def edit; end

  def new; end

  def create
    @article = Article.new article_params
    if @article.save
      redirect_to @article, notice: "Article créé"
    else
      flash[:alert] = "Une erreur est survenue"
      render 'new', status: :unprocessable_entity
    end
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: "Article mis à jour"
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy, notice: "Article supprimé"

    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end

  def set_article
    @article = params[:id].present? ? Article.find(params[:id]) : Article.new
  end
end
