User.create!(name: "admin",
             email: "admin@gmail.com",
             password: "foobar",
             password_confirmation: "foobar",
             admin: true)

1.times do |n|
  email = Faker::Internet.email
  name = "name"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               )
end
