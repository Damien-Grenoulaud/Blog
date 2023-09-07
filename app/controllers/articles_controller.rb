# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :login_relocate_obligatory, except: %i[index show]
  before_action :set_article, except: %i[index create]
  before_action :verif_user, only: %i[update edit destroy]

  def index
    @articles = Article.filter(params.slice(:title,
                                            :categorie)).includes(:user).article_user.order(:title).page params[:page]
  end

  def show
    return unless params[:turbo].present?

    render turbo_stream: [
      turbo_stream.replace('divModal', partial: 'articles/modalArticle', locals: { article: @article })
    ]
  end

  def dashboard; end

  def edit; end

  def new; end

  def create
    @article = Article.new article_params
    if @article.save
      redirect_to @article, notice: 'Article créé'
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def update
    return unless @article.updelatable

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    return unless @article.updelatable

    @article.destroy
    redirect_to articles_path, notice: 'Article supprimé'
  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end

  def set_article
    @article = params[:id].present? ? Article.find(params[:id]) : Article.new
  end

  def verif_user
    redirect_to welcome_index_path, alert: 'Accés refusé' unless @article.updelatable?
  end
end
