# frozen_string_literal: true

# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  text       :text
#  title      :string
#  users_type :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  users_id   :integer
#
# Indexes
#
#  index_articles_on_users  (users_type,users_id)
#
class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  validates :title, presence: true,
                    length: { minimum: 5 }

  belongs_to :user, optional: true
  before_create :set_user

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
end
