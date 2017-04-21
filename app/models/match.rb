class Match < ApplicationRecord
  has_and_belongs_to_many :users

  def self.generate(date = Date.today.strftime("%F"))
    puts "about to generate, date: #{date}"
    students_without_match = User.select{|user| user[:admin] == false && user.matches.select{|match| match.date.strftime("%F") == date }.length < 1}
    student_ids = students_without_match.map{|student| student.id}.shuffle
    self.match_student(student_ids, date)
  end

  def self.match_student(students, date)
  puts "matching student"
    students = self.assign_left_over(students, date) if students.length <= 2 && students.length > 0
    return if students.length == 0
    current_student = students.first
    match = self.make_match(students, current_student, date)
    students = students.select{|student| student != match && student != current_student}
    self.match_student(students, date)
  end

  def self.make_match(students, current_student, date)
    other_students = self.other_students(students, current_student)
    match = self.find_match(other_students, current_student)
    Match.create(date: date, user_ids: [match, current_student])
    match
  end

  def self.find_match(other_students, current_student)
    minimum_matched = 100000
    other_students.each do |other_student|
      matches = self.times_matched(other_student, current_student)
      if matches < minimum_matched
        minimum_matched = matches
        @matched_student = other_student
      end
      return @matched_student if minimum_matched == 0
    end
    @matched_student
  end

  def self.times_matched(other_student, current_student)
    matches =  User.find(current_student).matches.select{|match| match.user_ids.include?(other_student) && match.user_ids.include?(current_student)}.length ## faster than checking through matches
    matches
  end

  def self.other_students(students, current_student)
    other_students = students.select{|student| student != current_student }
    other_students
  end

  def self.assign_left_over(students, match_date)
    if students.length == 1
      assigned = self.assign_to_loner(students, match_date)
      return [] if assigned
    end
    Match.create(date: match_date, user_ids: students)
    return []
  end

  def self.assign_to_loner(students, match_date)
    unmatched = Match.select{|match| match.users.length == 1 && match.date.strftime("%F") == match_date }.first
    return false if(!unmatched)
    students << unmatched.users.first.id
    unmatched.update(user_ids: students)
    return true
  end

end
