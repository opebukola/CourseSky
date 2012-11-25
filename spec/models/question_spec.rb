require 'spec_helper'

describe Question do
	describe "#last_attempt(quiz)" do
		it "should return an empty set if no attempts" do
			question = FactoryGirl.create(:question)
			quiz = Quiz.create!


			question.last_attempt(quiz).should be_nil
		end
		it	"should return last attempt with multiple attempts" do
			question = FactoryGirl.create(:question)
			quiz = Quiz.create!
			user = FactoryGirl.create(:user)
			attempt1 = quiz.attempts.build
				attempt1.user = user
				attempt1.question = question
			attempt1.save
			attempt2 = quiz.attempts.build
				attempt2.user = user
				attempt2.question = question
			attempt2.save
				

			question.last_attempt(quiz).should == attempt2
		end

		# it	"should return correct attempt if only one question" do
		# 	user = FactoryGirl.create!(:user)
		# 	quiz = user.quizzes.create!
		# 	question = Question.create!
		# 	attempt1 = quiz.attempts.create!(user: user, question: question)
		# 	attempt2 = quiz.attempts.create!(user: user, question: question)


		# 	quiz.unique_questions_attempted
		# end
	end
end