namespace :ancien_article do
    task inactif_auto: :environment do
        @dateAncienne = Time.current - 1.month
        Article.where.not(id: Article.joins(:comments).where(comments: {created_at:  @dateAncienne..})).update(status_attributes: {label: :inactif})
        #status_attributes => has_one
        #statuses_attributes => has_many
    end
    task inactif_suppression: :environment do
        @dateAncienne = Time.current - 1.month
        Article.joins(:status).where(status: {label: :inactif}).where.not(id: Article.where(updated_at:  @dateAncienne..)).destroy_all
    end

end
