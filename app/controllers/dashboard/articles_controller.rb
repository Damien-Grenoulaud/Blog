# frozen_string_literal: true

class Dashboard::ArticlesController < Dashboard::DashboardController
  before_action :login_relocate_obligatory, except: [:index, :show]
  before_action :set_article, except: [:index,:create]

  def index
    #Comment.all.update(updated_at: Time.current - 1.year)
    #Status.all.update(label: "actif");
    #exec("rails ancien_article:inactif_auto")
    
    @articles = Article.filter(params.slice(:title, :categorie, :status)).article_admin.includes(:status)
  end

  def show;
    if params[:turbo].present?
      render turbo_stream: [
        turbo_stream.replace("divModal",partial: 'articles/modalArticle',locals: {article:@article})
      ]
    end
  end

  def dashboard; end

  def edit; end

  def change_status;
    if params[:article][:status] == "true"
      @article.status.actif!
    else
      @article.status.inactif!
    end
    render turbo_stream: [
      turbo_stream.update("article_#{@article.id}",partial: 'dashboard/articles/article',locals: {article:@article})
    ]
  end

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
    article_id = params[:id] || params[:article_id]
    @article = article_id.present? ? Article.find(article_id) : Article.new
  end
  
end
