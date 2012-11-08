# == Schema Information
#
# Table name: quiz_skills
#
#  id         :integer          not null, primary key
#  quiz_id    :integer
#  skill_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class QuizSkillTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
