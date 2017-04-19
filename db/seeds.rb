User.delete_all
Match.delete_all

AdminMandy = User.create(first_name: "Mandy", last_name: "Admin", admin: true, email: "mandy@express.biz", password: "abc123")
StudentSteve = User.create(first_name: "Steve", last_name: "Student", admin: false, email: "steve@express.biz", password: "abc123")
Jack = User.create(first_name: "Jack", last_name: "Rabbit", admin: false, email: "jack@express.biz", password: "abc123")
Jane = User.create(first_name: "Jane", last_name: "GI", admin: false, email: "jane@express.biz", password: "abc123")
Amanda = User.create(first_name: "Amanda", last_name: "Adnama", admin: false, email: "amanda@express.biz", password: "abc123")
Dave = User.create(first_name: "Dave", last_name: "Evad", admin: false, email: "steve@express.biz", password: "abc123")

puts "Created users"

match1 = Match.create(date: Date.yesterday, users: [StudentSteve, Amanda])
match1 = Match.create(date: Date.today, users: [StudentSteve, Jack])
match2 = Match.create(date: Date.today, users: [Dave, Amanda])
match3 = Match.create(date: Date.tomorrow, users: [StudentSteve, Jane])
match4 = Match.create(date: Date.yesterday, users: [Jane, Amanda])

puts "Created matches"
