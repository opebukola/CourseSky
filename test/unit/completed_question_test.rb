# == Schema Information
#
# Table name: completed_questions
#
#  id          :integer          not null, primary key
#  student_id  :integer          not null
#  question_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class CompletedQuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
