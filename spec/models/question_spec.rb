# == Schema Information
#
# Table name: questions
#
#  id                :integer          not null, primary key
#  hint              :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  question_type     :string(255)
#  explanation_text  :text
#  question_text     :text
#  difficulty        :integer
#  question_image    :string(255)
#  explanation_video :string(255)
#

require 'spec_helper'

describe Question do
	before do
	  @question = Question.new(
	  						question_type: "Enter Response",
	  						question_text: "Question Text",
	  						difficulty: 1,
	  						hint: "hint")
	  skill = FactoryGirl.create(:skill)
	  @question.skills << skill
	  answer = FactoryGirl.create(:answer)
	  @question.answers << answer
	end

	subject { @question }

	it { should respond_to(:answers) }
	it { should respond_to(:attempts) }
	it { should respond_to(:lessons) }
	it { should respond_to(:skills) }

	it { should be_valid }

	describe "#last_quiz_attempt(quiz)" do
		it "should return an empty set if no attempts" do
			question = FactoryGirl.create(:question)
			quiz = FactoryGirl.create(:quiz)

			question.last_quiz_attempt(quiz).should be_nil
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
				

			question.last_quiz_attempt(quiz).should == attempt2
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
