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
for n in 0..50
    @article = Article.create([title: Faker::Name.name,text: Faker::Markdown.emphasis])
    for y in 0..3
        Comment.create([article_id: @article.first.id,commenter: Faker::Name.name,body: Faker::Markdown.emphasis])
        

    end
    puts Faker::Name.name
end

User.create([nom: "Test",prenom: "Jacques",mail: "jacques@test.com",password: "motdepasse",password_confirmation:"motdepasse"])

puts "Seeding done."