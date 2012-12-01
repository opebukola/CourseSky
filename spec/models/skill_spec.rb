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
	describe "#questions_attempted(user)" do
		let(:user){FactoryGirl.create(:user)}
		it	"should return empty set if no attempts" do
			skill = FactoryGirl.create(:skill)
			question = skill.questions.build

			skill.questions_attempted(user).should be_empty
		end

		describe "with multiple attempts on question " do
			it "should return unique number of questions" do
				# some code that defines multiple attempts for a question 
				# with same skill

				#verify skill.questions_attempted(user) has no duplicates
			end
			
		end
	end

	describe "#accuracy(user)" do
		it "should return average for all questions with skill" do
			#find questions, find last attempts, average accuracy
		end
		
	end
	
end
