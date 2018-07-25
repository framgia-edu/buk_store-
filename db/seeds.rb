# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
10.times do |n|
  genre = Faker::Book.genre
  Category.create!(category_name: genre)
end

Book.__elasticsearch__.create_index!(force: true)

categories = Category.order(:created_at).take(6)
10.times do |n|
  name = Faker::Book.title
  author = Faker::Book.author
  publisher = Faker::Book.publisher
  categories.each {|category| category.books.create!(name: name, author: author, publisher: publisher, price: 10, quantity: 10)}
end

Cart.destroy_all
