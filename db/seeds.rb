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
  categories.each {|category| category.books.create!(name: name, author: author, publisher: publisher)}
end

# User.create!(name: "admin",
#   gender: "male",
#   birthday: "04/05/1997",
#   address: "VXT",
#   phone_number: "01686741787",
#   email: "admin@gmail.com",
#   password: "123456",
#   password_confirmation: "123456",
#   admin: true
# )

# 99.times do |n|
#   name  = Faker::Name.name
#   email = "example-#{n+1}@railstutorial.org"
#   password = "password"
#   User.create!(name: name,
#     gender: "male",
#     birthday: "04/05/1996",
#     address: "VXT",
#     phone_number: "01686741789",
#     email: email,
#     password: password,
#     password_confirmation: password)
# end
