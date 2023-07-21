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

    def full_name
        "#{self.name} - #{self.prenom}" 
    end
end
