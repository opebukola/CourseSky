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
	# it "should require a user" do
	# 	quiz = Quiz.new

	# 	quiz.should_not be_valid
	# 	quiz.errors[:user_id].should_not be_empty
	# end

	# it "should require a lesson" do
	# 	quiz = Quiz.new

	# 	quiz.should_not be_valid
	# 	quiz.errors[:lesson_id].should_not be_empty
	# end

	# it "should require a course" do
	# 	quiz = Quiz.new

	# 	quiz.should_not be_valid
	# 	quiz.errors[:course_id].should_not be_empty
	# end

	# describe "#final_questions_attempted" do
	# 	it "should return unique list of questions" do
	# 		# quiz = Quiz.new
	# 		# quiz.user = FactoryGirl.create(:user)
	# 		# quiz.course = FactoryGirl.create(:course)
	# 		# quiz.lesson = FactoryGirl.create(:lesson)
	# 		quiz = FactoryGirl.create(:quiz)
	# 		question = FactoryGirl.create(:question)
	# 		attempt1 = quiz.attempts.build
	# 			attempt1.user = quiz.user
	# 			attempt1.question = question
	# 		attempt1.save
	# 		attempt2 = quiz.attempts.build
	# 			attempt2.user = quiz.user
	# 			attempt2.question = question
	# 		attempt2.save

	# 		quiz.final_attempts.should_not be_nil
	# 		quiz.final_attempts.count.should == 1
	# 	end
		
	# end

end
