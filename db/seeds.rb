User.create!(name:  "Bijal Patel",
             email: "bijalpatel@hotmail.com",
             password:              "password",
             password_confirmation: "password",
             admin: true)

User.create!(name:  "Matthew Hopkins",
             email: "moebaca@hotmail.com",
             password:              "Password1",
             password_confirmation: "Password1",
             admin: true)

User.create!(name:  "Example User"
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar")

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end
