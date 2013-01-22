# == Schema Information
#
# Table name: skills
#
#  id          :integer          not null, primary key
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  ancestry    :string(255)
#

require 'spec_helper'

describe Skill do
	let(:user){FactoryGirl.create(:user)}
	let(:quiz) {FactoryGirl.create(:quiz)}
	let(:skill) {FactoryGirl.create(:skill)}
	let(:question1) {FactoryGirl.create(:question)}
	let(:question2) {FactoryGirl.create(:question)}
	# let(:attempt1) {quiz.attempts.build}
	# let(:attempt2) {quiz.attempts.build}

	describe "#questions_attempted(user)" do	
		it	"should return empty set if no attempts" do
			skill.questions << question1

			skill.questions_attempted(user).should be_empty
		end

		describe "with multiple attempts on question " do
			it "should return unique number of questions" do
				skill.questions << question1

				quiz.user = user

				attempt1.user = user
				attempt1.question = question1
				attempt1.save

				attempt2.user = user
				attempt2.question = question1
				attempt2.save

				skill.questions_attempted(user).should_not be_empty
				skill.questions_attempted(user).flatten.size.should == 1


				# skill.questions_attempted(user).should == question 
			end
		end
	end

	describe "#questions_correct(user)" do
		it "should return questions answered correct w/ skill" do
			
			skill.questions << question1

			quiz.user = user

			attempt1.user = user
			attempt1.question = question1
			attempt1.correct = false
			attempt1.save

			attempt2.user = user
			attempt2.question = question1
			attempt2.correct = true
			attempt2.save

			skill.questions_correct(user).should_not be_empty
			skill.questions_correct(user).flatten.size.should == 1

			# skills.questions_correct_user).should include question2
		end

		it "should return last attempt on question" do
			
			skill.questions << question1

			quiz.user = user

			attempt1.user = user
			attempt1.question = question1
			attempt1.correct = true
			attempt1.save

			attempt2.user = user
			attempt2.question = question1
			attempt2.correct = false
			attempt2.save

			skill.questions_correct(user).should be_empty
			skill.questions_correct(user).flatten.size.should == 0

			# skills.questions_correct_user).should include question2
		end
	end

	describe "#accuracy(user)" do
		it "should return average for all questions with skill" do

			skill.questions << question1
			skill.questions << question2 

			quiz.user = user

			attempt1.user = user
			attempt1.question = question1
			attempt1.correct = false
			attempt1.save

			attempt2.user = user
			attempt2.question = question2
			attempt2.correct = true
			attempt2.save

			skill.accuracy(user).should == 0.5	
		end
		
	end
	
end
