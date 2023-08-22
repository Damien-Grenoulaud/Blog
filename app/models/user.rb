# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  admin           :boolean
#  mail            :string
#  nom             :string
#  password_digest :string
#  prenom          :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
    has_secure_password
    has_one_attached :avatar
    has_one :status, as: :linkable

    has_one_attached :avatar do |attachable|
        attachable.variant :light, resize_to_limit: [100, 100]
        attachable.variant :medium, resize_to_limit: [500, 500]
        attachable.variant :grande, resize_to_limit: [1000, 1000]
    end

    def full_name
        "#{self.nom} - #{self.prenom}" 
    end
end
