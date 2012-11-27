# == Schema Information
#
# Table name: quizzes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  lesson_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  course_id  :integer
#

require 'spec_helper'

describe Quiz do
	it "should require a user" do
		quiz = Quiz.new

		quiz.should_not be_valid
		quiz.errors[:user_id].should_not be_empty
	end

	it "should require a lesson" do
		quiz = Quiz.new

		quiz.should_not be_valid
		quiz.errors[:lesson_id].should_not be_empty
	end

	it "should require a course" do
		quiz = Quiz.new

		quiz.should_not be_valid
		quiz.errors[:course_id].should_not be_empty
	end

end
