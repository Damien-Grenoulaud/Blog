# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
puts "Seeding..."

Article.destroy_all
User.destroy_all

User.create([nom: "admin",prenom: "admin",mail: "admin@test.com",password: "motdepasseadmin",password_confirmation: "motdepasseadmin",admin: true])

User.create([nom: Faker::Name.name,prenom: Faker::Name.first_name,mail: "user@test.com",password: "motdepasseuser",password_confirmation:"motdepasseuser",admin:false])


@user = User.create([nom: Faker::Name.name,prenom: Faker::Name.first_name,mail: "test@test.com",password: "motdepasse",password_confirmation:"motdepasse",admin:false])
@idUser = @user.first.id
for n in 0..50
    
    @article = Article.create([title: Faker::Name.name,text: Faker::Markdown.emphasis,users_id: @idUser])
    for y in 0..3
        Comment.create([article_id: @article.first.id,commenter: Faker::Name.name,body: Faker::Markdown.emphasis])
        

    end
    puts Faker::Name.name
end

# TODO La tu pourrais utiliser la class Faker comme au dessus pour le nom et prenom
# le mail pourrais etres test@test.com que ce soit plus parlant.


puts "Seeding done."