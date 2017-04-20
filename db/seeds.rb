User.delete_all
Match.delete_all

JohnnyAdmin = User.create(first_name: "Johnny", last_name: "Admin", admin: true, email: "johnny@express.biz", password: "abc123")
AdminMandy = User.create(first_name: "Mandy", last_name: "Admin", admin: true, email: "mandy@express.biz", password: "abc123")

3.times do
  User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, admin: false, email: Faker::Internet.email, password: "student")
end
puts "Created users"
