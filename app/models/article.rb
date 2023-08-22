# frozen_string_literal: true

# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  categorie  :integer          default("actualité")
#  text       :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_one :status, as: :linkable
  enum :categorie, [ :actualité, :santé, :Jeux ]
  scope :article_admin, -> { where.not(status: :actif) }
  validates :title, presence: true,
                    length: { minimum: 5 }

  belongs_to :user, optional: true
  before_create :set_user
  before_create :set_status

  def updelatable?
    self.editable? && self.deletable?
  end

  def editable?
    Current.user&.admin? || self.user == Current.user
  end

  def deletable?
    Current.user&.admin? || self.user == Current.user
  end

  def set_user
    self.user = Current.user
  end
  def set_status
    self.status = Status.new(label: :en_cours);
  end
end
