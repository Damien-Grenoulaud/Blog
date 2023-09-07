# frozen_string_literal: true

# == Schema Information
#
# Table name: statuses
#
#  id            :integer          not null, primary key
#  label         :string
#  linkable_type :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  linkable_id   :integer          not null
#
# Indexes
#
#  index_statuses_on_linkable  (linkable_type,linkable_id)
#
class Status < ApplicationRecord
  belongs_to :linkable, polymorphic: true
  enum :label, { actif: 'actif', inactif: 'inactif', en_cours: 'en_cours' }
end
