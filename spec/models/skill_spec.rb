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
		it	"should return empty set if no attempts" do
			skill = FactoryGirl.create(:skill)
			user = FactoryGirl.create(:user)


			skill.questions_attempted(user).should be_empty
		end
	end
	
end
