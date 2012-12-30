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
#  lesson_id         :integer
#

require 'spec_helper'

describe Question do
	let(:user) { FactoryGirl.create(:user) }
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
	it { should respond_to(:lesson) }
	it { should respond_to(:skills) }

	it { should be_valid }

	# describe "#last_quiz_attempt(quiz)" do
	# 	it "should return an empty set if no attempts" do
	# 		question = FactoryGirl.create(:question)
	# 		quiz = FactoryGirl.create(:quiz)

	# 		question.last_quiz_attempt(quiz).should be_nil
	# 	end
	# 	it	"should return last attempt with multiple attempts" do
	# 		question = FactoryGirl.create(:question)
	# 		quiz = FactoryGirl.create(:quiz)
	# 		user = FactoryGirl.create(:user)
	# 		attempt1 = quiz.attempts.build
	# 			attempt1.user = user
	# 			attempt1.question = question
	# 		attempt1.save
	# 		attempt2 = quiz.attempts.build
	# 			attempt2.user = user
	# 			attempt2.question = question
	# 		attempt2.save
				

	# 		question.last_quiz_attempt(quiz).should == attempt2
	# 	end

	# 	it	"should return correct attempt if only one question" do
	# 		user = FactoryGirl.create!(:user)
	# 		quiz = user.quizzes.create!
	# 		question = Question.create!
	# 		attempt1 = quiz.attempts.create!(user: user, question: question)
	# 		attempt2 = quiz.attempts.create!(user: user, question: question)


	# 		quiz.unique_questions_attempted
	# 	end
	# end


	describe "#last_attempt_by(user)" do
		it "should return last question attempt" do
			q1 = FactoryGirl.create(:question)
			attempt1 = user.attempts.build
			attempt1.question = q1
			attempt1.save
			attempt2 = user.attempts.build
			attempt2.question = q1
			attempt2.save

			q1.last_attempt_by(user).should eq(attempt2)
		end
	end

	describe "all_attempts_by(user)" do
		it "should return all question attempts" do
			q1 = FactoryGirl.create(:question)
			attempt1 = user.attempts.build
			attempt1.question = q1
			attempt1.save
			attempt2 = user.attempts.build
			attempt2.question = q1
			attempt2.save

			q1.all_attempts_by(user).should == [attempt1, attempt2]
		end
	end

	describe "correct_attempt?(user)" do
		it "should be true if user's last question attempt is correct" do
			question1 = FactoryGirl.create(:question)
			question2 = FactoryGirl.create(:question)
			attempt1 = user.attempts.build
			attempt1.question = question1
			attempt1.correct = true
			attempt1.save
			attempt2 = user.attempts.build
			attempt2.question = question2
			attempt2.correct = true
			attempt2.save
			attempt3 = user.attempts.build
			attempt3.question = question2
			attempt3.save

			question1.correct_attempt?(user).should be_true
			question2.correct_attempt?(user).should be_false
		end		
	end
end
