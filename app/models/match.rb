class Match < ApplicationRecord
  has_and_belongs_to_many :users

  def available_matches(current_student, student_id)
    # previous_matches = current_student.matches.select{|hash| hash[:id]}
    # students.select{|hash| hash[:id] !== }
  end


  def self.matchable_students(matchables, current_student)
    least_matched = self.minimum_matched(matchables, current_student)
    matchables = matchables.select {|matchable_student| matchable_student != current_student && self.times_matched(current_student, matchable_student) == least_matched }
  end

  def self.minimum_matched(matchables, current_student)
    minimum_matched = 0
    matchables.each do |student|
      matches = self.times_matched(current_student, student)
      minimum_matched = matches if matches > minimum_matched
    end
    minimum_matched
  end

  def self.times_matched(current_student, matchable_student)
    Match.select{|match| match.users.include?(matchable_student) && match.users.include?(current_student)}.length
  end

  def self.make_match(matchables)
    match = matchables.sample
  end

  def self.match_student(matchables, current_student, date)
    if current_student.matches.select{|match| match[:date] == date }.length != 0
      matchables = matchables.select{|student| student != current_student }
    else
      matchables = matchable_students(matchables, current_student)
      match = self.make_match(matchables)
      puts "Student #{current_student.name} matched with #{match.name}"
      Match.create(date: date, users: [match, current_student])
      matchables = matchables.select{|student| student != match }
    end
    puts "Unmatched students:"
    matchables.each {|student| puts student.name }

    return if matchables.length <= 1
    match_student(matchables, matchables.first, date)
  end

  def self.generate(date = Date.today)
    students = User.select{|hash| hash[:admin] == false }
    self.match_student(students, students.first, date)
    puts "yay made the matches"
  end
end
