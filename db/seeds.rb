User.create!(name: "admin",
  gender: 1,
  birthday: "04/05/1997",
  address: "VXT",
  phone_number: "01686741787",
  email: "admin@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  user_type: 2,
  activated: true
)

User.create!(name: "employee",
  gender: 2,
  birthday: "05/05/1997",
  address: "VXT",
  phone_number: "01686745999",
  email: "employee@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  user_type: 1,
  activated: true
)

20.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
    gender: 1,
    birthday: "04/05/1996",
    address: "VXT",
    phone_number: "01686741789",
    email: email,
    password: password,
    password_confirmation: password)
end
