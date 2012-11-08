# == Schema Information
#
# Table name: lesson_skills
#
#  id         :integer          not null, primary key
#  lesson_id  :integer
#  skill_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class LessonSkillTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
