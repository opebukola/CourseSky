# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

def create_user
  user = User.new
  user.name = "test"
  user.password = "123456"
  user.email = "test@test.com"
  user.admin = true
  user.save!

  puts "created user:"
  y user

  user
end

# later we can use machinist or factory_girl to do the job
def create_course(user)
  course = Course.new(:description => Faker::Lorem.paragraph, :published => true, :title => Faker::Name.name)
  course.user = user
  course.featured = true
  course.grade_level = GradeLevel.new(:name => ["one", "two", "three"][rand(3)])
  course.save(:validate => false)

  puts "created course:"
  y course

  3.times { create_lesson(course) }
end

def create_lesson(course)
  lesson = Lesson.new(:intro => Faker::Lorem.paragraph, :title => Faker::Name.name)
  lesson.course = course
  lesson.user = course.user
  lesson.save!

  puts "created lesson:"
  y lesson

  3.times { create_choice_question(lesson) }
  2.times { create_question(lesson) }
end

def create_question(lesson)
  question = Question.new(:prompt => Faker::Lorem.sentence, :explanation => Faker::Lorem.paragraph, :hint => Faker::Lorem.sentence, :question_type => "Enter Response")
  question.lesson = lesson
  question.course = lesson.course
  question.save

  puts "created question:"
  y question
end

def create_choice_question(lesson)
  question = Question.new(:prompt => Faker::Lorem.sentence, :explanation => Faker::Lorem.paragraph, :hint => Faker::Lorem.sentence, :question_type => "Multiple Choice")
  question.lesson = lesson
  question.course = lesson.course
  question.save

  puts "created question:"
  y question

  (1..4).each do |i| 
    ans = Answer.new(:content => Faker::Lorem.sentence, :correct => i == 4)
    ans.question = question
    ans.save
  end
end

user = User.first || create_user
3.times { create_course(user) }
