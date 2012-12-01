# == Schema Information
#
# Table name: questions
#
#  id            :integer          not null, primary key
#  hint          :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  question_type :string(255)
#  explanation   :text
#  question_text :text
#  difficulty    :integer
#

require 'spec_helper'

describe Question do
	describe "#last_attempt(quiz)" do
		it "should return an empty set if no attempts" do
			question = FactoryGirl.create(:question)
			quiz = FactoryGirl.create(:quiz)

			question.last_attempt(quiz).should be_nil
		end
		it	"should return last attempt with multiple attempts" do
			question = FactoryGirl.create(:question)
			quiz = FactoryGirl.create(:quiz)
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
