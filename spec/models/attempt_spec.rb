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
#  quiz_id     :integer
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

	it "should save a score" do
		
	end
end
