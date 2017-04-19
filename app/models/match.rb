class Match < ApplicationRecord
  has_and_belongs_to_many :users

  def self.matchable_students(matchables, current_student)
    least_matched = self.minimum_matched(matchables, current_student)
    matchables.select {|matchable_student| matchable_student != current_student && self.times_matched(current_student, matchable_student) <= least_matched }
  end

  def self.minimum_matched(students, current_student)
    minimum_matched = 100000
    students.each do |student|
      matches = self.times_matched(current_student, student)
      minimum_matched = matches if matches < minimum_matched
    end
    minimum_matched
  end

  def self.times_matched(current_student, matchable_student)
    Match.select{|match| match.users.include?(matchable_student) && match.users.include?(current_student)}.length
  end

  def self.make_match(matchable_students)
    matchable_students.sample
  end

  def self.match_student(students, current_student, date)
    if current_student.matches.select{|match| match[:date].strftime("%F") == date }.length > 0
      students = students.select{|student| student != current_student }
      puts "student #{current_student.name} already matched on this day"
      puts '-'* 50
    else
      matchables = matchable_students(students, current_student)
      match = self.make_match(matchables)
      puts "Student #{current_student.name} matched with #{match.name}"
      Match.create(date: date, users: [match, current_student])
      students = students.select{|student| student != match && student != current_student}
    end
    puts "Unmatched students:"
    students.each {|student| puts student.name }
    puts "number of students unmatched: #{students.length}"
    return if students.length <= 1
    self.match_student(students, students.first, date)
  end

  def self.generate(date)
    puts "About to match students"
    students = User.select{|hash| hash[:admin] == false }
    puts "students to be matched: #{students.length}"
    self.match_student(students, students.first, date)
    puts "yay made the matches"
  end
end
