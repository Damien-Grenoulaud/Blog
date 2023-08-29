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
  scope :filter_by_title, -> (title) { where "title like '%#{title}%'" }
  include Filterable

  has_many :comments, dependent: :destroy
  has_one :status, as: :linkable, dependent: :destroy
  accepts_nested_attributes_for :status
  enum :categorie, %i[actualité santé Jeux]
  scope :article_admin, -> { joins(:status) }
  scope :article_user, -> { joins(:status).where(status: {id: Status.actif}) }
  validates :title, presence: true,
                    length: { minimum: 5 }

  belongs_to :user, optional: true
  before_create :set_user
  before_create :set_status

  def updelatable?
    editable? && deletable?
  end

  def editable?
    Current.user&.admin? || user == Current.user
  end

  def deletable?
    Current.user&.admin? || user == Current.user
  end

  def set_user
    self.user = Current.user
  end

  def set_status
    self.status = Status.new(label: :en_cours)
  end
end
