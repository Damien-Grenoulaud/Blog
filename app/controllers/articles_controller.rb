# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :login_relocate_obligatory, except: [:index, :show]
  before_action :set_article, except: [:index,:create]
  before_action :verif_user, only: [:update,:edit,:destroy]

  def index
    if params[:titleSearch].present?
        @articles = Article.all.includes(:user).where "title like '%#{params[:titleSearch]}%'"
    else
        @articles = Article.all.includes(:user)
    end
  end

  def show;
    if params[:turbo].present?
      render turbo_stream: [
        turbo_stream.replace("divModal",partial: 'articles/modalArticle',locals: {article:@article})
      ]
    end
  end

  def edit; end

  def new; end

  def create
    @article = Article.new article_params
    if @article.save
      redirect_to @article, notice: "Article créé"
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def update
    if(@article.user == @current_user || @current_user.admin?)
      if @article.update(article_params)
        redirect_to @article
      else
        render 'edit', status: :unprocessable_entity
      end
    end
  end

  def destroy
    @article.destroy

    redirect_to articles_path, notice: "Article supprimé"
  end

  public
  def editable
    if(article.users_id != @current_user.id && @current_user.admin == false)
      return false
    else
      return true
    end
  end
  def deletable
    if(article.users_id != @current_user.id && @current_user.admin == false)
      return false
    else
      return true
    end
  end
  private

  def article_params
    params.require(:article).permit(:title, :text)
  end

  def set_article
    @article = params[:id].present? ? Article.find(params[:id]) : Article.new
  end
  
  def verif_user
    redirect_to welcome_index_path, alert: "Accés refusé" unless @article.updelatable?
  end
  
end
