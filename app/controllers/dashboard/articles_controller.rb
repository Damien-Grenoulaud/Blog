# frozen_string_literal: true

module Dashboard
  class ArticlesController < Dashboard::DashboardController
    before_action :login_relocate_obligatory, except: %i[index show]
    before_action :set_article, except: %i[index create]

    def index
      # Comment.all.update(updated_at: Time.current - 1.year)
      # Status.all.update(label: "actif");
      # exec("rails ancien_article:inactif_auto")

      @articles = Article.filter(params.slice(:title, :categorie,
                                              :status)).article_admin.includes(:status).order(:title).page params[:page]
    end

    def show
      return unless params[:turbo].present?

      render turbo_stream: [
        turbo_stream.replace('divModal', partial: 'articles/modalArticle', locals: { article: @article })
      ]
    end

    def dashboard; end

    def edit; end

    def change_status
      puts 'testnormal'
      if params[:article][:status] == 'true'
        @article.status.actif!
      else
        @article.status.inactif!
      end
      render turbo_stream: [
        turbo_stream.update("article_#{@article.id}", partial: 'dashboard/articles/article',
                                                      locals: { article: @article })
      ]
    end

    def bulk_status
      @listeArticles = ''
      puts params
      if params[:article][:listeArticlesValid].present?
        @listeArticles = params[:article][:listeArticlesValid].split('|')
      elsif params[:article][:listeArticlesNonValid].present?
        @listeArticles = params[:article][:listeArticlesNonValid].split('|')
      end
      @articleIndex = Article.where(id: @listeArticles)
      if params[:article][:status] == 'true'
        @articleIndex.update(status_attributes: { label: :actif })
      else
        @articleIndex.update(status_attributes: { label: :inactif })
      end

      @articles = Article.filter(params.slice(:title, :categorie,
                                              :status)).article_admin.includes(:status).order(:title).page params[:page]

      render turbo_stream: [
        turbo_stream.update('tableauArticles', partial: 'dashboard/articles/index/tableau',
                                               locals: { params:, articles: @articles })
      ]
    end

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
      article_id = params[:id] || params[:article_id]
      @article = article_id.present? ? Article.find(article_id) : Article.new
    end
  end
end
