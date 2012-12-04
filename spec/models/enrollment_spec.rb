# == Schema Information
#
# Table name: enrollments
#
#  id                 :integer          not null, primary key
#  student_id         :integer
#  enrolled_course_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'spec_helper'

describe Enrollment do
	it	"should require a user" do
		enrollment = Enrollment.new

		enrollment.should_not be_valid
	end

	it "should require a course" do
		enrollment = Enrollment.new
		enrollment.student = FactoryGirl.create(:user)

		enrollment.should_not be_valid
		
	end

	describe "user#enrolled(course)" do
		it "should be true if user is enrolled in course" do
			enrollment = Enrollment.new
			student = FactoryGirl.create(:user)
			course = FactoryGirl.create(:course)
			enrollment.student = student
			enrollment.enrolled_course = course
			enrollment.save


			student.enrolled?(course).should be_true
		end
	end

	describe "user#enroll!(course)" do
		it "should create a new enrollment" do
			student = FactoryGirl.create(:user)
			course = FactoryGirl.create(:course)
			student.enroll!(course)

			student.enrolled?(course).should be_true
		end
	end

	describe "when user takes a practice quiz in a course" do
		it "should enroll user in course" do
			student = FactoryGirl.create(:user)
			course = FactoryGirl.create(:course)
			quiz = Quiz.new
			quiz.lesson = FactoryGirl.create(:lesson)
			quiz.course = course
			quiz.user = student
			quiz.save

			student.enrolled?(course).should be_true
		end
	end


	# describe "when user submits check question" do
	# 		student = FactoryGirl.create(:user)
	# 		course = FactoryGirl.create(:course)
	# 		lesson_item = LessonItem.new
	# 		lesson_item.course = course
	# 		lesson_item.save

	# 		visit check_lesson_item_path(lesson_item)

	# 		student.enrolled?(course).should be_true
	# end

	# describe "when a user engages in a course" do
	# 	let(:user) {FactoryGirl.create(:user)}
	# 	let(:course) {FactoryGirl.create(:course)}

	# 	it "should enroll user in course after quiz" do
	# 		quiz = course.quizzes.build

	# 		user.enrolled?(course).should be_true
	# 	end

	# 	# describe "when a user takes a practice quiz" do
	# 	# 	quiz = course.quizzes.build
			
	# 	# 	user.enrolled?(course).should be_true
	# 	# end

	# 	describe "when a user answers an 'ask' " do
	# 		visit check_lesson_item_path

	# 		user.enrolled?(course).should be_true
	# 	end
		
	# end
end
