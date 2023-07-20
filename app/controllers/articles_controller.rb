# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :login_relocate_obligatory, except: [:index, :show]
  before_action :set_article, except: [:index,:create]
  before_action :verif_user, only: [:update,:edit,:destroy]

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
    @article.users_id = @current_user.id
    if @article.save
      redirect_to @article, notice: "Article créé"
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def update
    if(@article.users_id == @current_user.id || @current_user.admin == true)
      @article.users_id = @current_user.id
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


  def editable
    if(@article.users_id != @current_user.id && @current_user.admin == false)
      return false
    else
      return true
    end
  end
  def deletable
    if(@article.users_id != @current_user.id && @current_user.admin == false)
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
    if(@article.users_id != @current_user.id && @current_user.admin == false)
      redirect_to welcome_index_path, alert: "Accés refusé"
    end
  end
  
end
