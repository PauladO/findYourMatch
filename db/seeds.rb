User.delete_all

AdminMandy = User.create(first_name: "Mandy", last_name: "Admin", student: false, admin: true, email: "mandy@express.biz", password: "abc123")
StudentSteve = User.create(first_name: "Steve", last_name: "Student", student: true, admin: false, email: "steve@express.biz", password: "abc123")
Jack = User.create(first_name: "Jack", last_name: "Rabbit", student: true, admin: false, email: "jack@express.biz", password: "abc123")
Jane = User.create(first_name: "Jane", last_name: "GI", student: true, admin: false, email: "jane@express.biz", password: "abc123")
Amanda = User.create(first_name: "Amanda", last_name: "Adnama", student: true, admin: false, email: "amanda@express.biz", password: "abc123")
Dave = User.create(first_name: "Dave", last_name: "Evad", student: true, admin: false, email: "steve@express.biz", password: "abc123")

puts "Created users"
