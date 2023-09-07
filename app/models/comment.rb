# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  body       :text
#  commenter  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :integer          not null
#  user_id    :integer
#
# Indexes
#
#  index_comments_on_article_id  (article_id)
#  index_comments_on_user_id     (user_id)
#
# Foreign Keys
#
#  article_id  (article_id => articles.id)
#
class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :user, optional: true
  before_create :set_user
  delegate :full_name, to: :user, allow_nil: true

  def set_user
    self.user = Current.user
  end

  def titulaire
    full_name || 'anonyme'
  end

  def deletable?
    Current.user&.admin? || user == Current.user
  end
end
