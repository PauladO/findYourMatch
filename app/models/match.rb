class Match < ApplicationRecord
  has_and_belongs_to_many :users

  def self.generate(date = Date.today)
    students_without_match = User.select{|user| user[:admin] == false && user.matches.select{|match| match.date.strftime("%F") == date }.length < 1}
    puts "students to be matched:"
    puts "_" * 100
    students_without_match.each {|student|  puts student.name }
    student_ids = students_without_match.map{|student| student.id}.shuffle
    self.match_student(student_ids, date)
  end

  def self.match_student(students, date)
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
        matched_student = other_student
      end
      return matched_student if minimum_matched == 0
    end
    debugger
    matched_student
  end

  def self.times_matched(other_student, current_student)
    matches = Match.select{|match| match.user_ids.include?(other_student) && match.user_ids.include?(current_student)}.length
    debugger
    matches
  end

  def self.other_students(students, current_student)
    other_students = students.select{|student| student != current_student }
    puts "the current student: #{current_student}"
    puts "the other students: #{other_students}"
    other_students
  end

  def self.assign_left_over(students, date)
    Match.create(date: date, user_ids: students)
    students = []
    return students
  end


end
