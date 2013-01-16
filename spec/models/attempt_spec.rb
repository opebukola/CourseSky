# == Schema Information
#
# Table name: attempts
#
#  id          :integer          not null, primary key
#  started_at  :datetime
#  ended_at    :datetime
#  correct     :boolean          default(FALSE)
#  question_id :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  response    :string(255)
#

require 'spec_helper'

describe Attempt do 
	it "should require a user" do
		attempt = Attempt.new
		attempt.quiz = Quiz.new
		attempt.question = Question.new


		attempt.should_not be_valid
		attempt.errors[:user_id].should_not be_empty
	end

	it "should calculate a score after saving" do
		quiz = FactoryGirl.create(:quiz)
		user = FactoryGirl.create(:user)
		question = FactoryGirl.create(:question)
		attempt1 = quiz.attempts.build
		attempt1.user = user
		attempt1.question = question
		attempt1.correct = false
		attempt1.save

		attempt2 = quiz.attempts.build
		attempt2.user = user
		attempt2.question = question
		attempt2.correct = true
		attempt2.save

		attempt1.calculate_score.should_not be_nil
		attempt2.calculate_score.should_not be_nil
		attempt2.calculate_score.should == 10
		
	end


end
