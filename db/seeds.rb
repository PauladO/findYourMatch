User.delete_all
Match.delete_all

AdminMandy = User.create(first_name: "Mandy", last_name: "Admin", admin: true, email: "mandy@express.biz", password: "abc123")
StudentSteve = User.create(first_name: "Steve", last_name: "Student", admin: false, email: "steve@express.biz", password: "abc123")
Jack = User.create(first_name: "Jack", last_name: "Rabbit", admin: false, email: "jack@express.biz", password: "abc123")
Jane = User.create(first_name: "Jane", last_name: "GI", admin: false, email: "jane@express.biz", password: "abc123")
Amanda = User.create(first_name: "Amanda", last_name: "Adnama", admin: false, email: "amanda@express.biz", password: "abc123")
Dave = User.create(first_name: "Dave", last_name: "Evad", admin: false, email: "dave@express.biz", password: "abc123")
JohnnyAdmin = User.create(first_name: "Johnny", last_name: "Admin", admin: true, email: "johnny@express.biz", password: "abc123")
Darrell = User.create(first_name: "Darrell", last_name: "Barrel", admin: false, email: "darrel@express.biz", password: "abc123")
Roger = User.create(first_name: "Roger", last_name: "Rabbit", admin: false, email: "roger@express.biz", password: "abc123")
Barbie = User.create(first_name: "Barbie", last_name: "Girl", admin: false, email: "barbie@express.biz", password: "abc123")
Grey = User.create(first_name: "Grey", last_name: "Lady", admin: false, email: "grey@express.biz", password: "abc123")
Jannett = User.create(first_name: "Jannett", last_name: "Jackson", admin: false, email: "Jannett@express.biz", password: "abc123")

puts "Created users"
