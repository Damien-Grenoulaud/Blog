# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  mail            :string
#  nom             :string
#  password_digest :string
#  prenom          :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
    has_secure_password
end
