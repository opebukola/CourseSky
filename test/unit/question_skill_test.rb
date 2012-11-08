# == Schema Information
#
# Table name: question_skills
#
#  id          :integer          not null, primary key
#  question_id :integer
#  skill_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class QuestionSkillTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
