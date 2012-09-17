require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
# == Schema Information
#
# Table name: questions
#
#  id            :integer         not null, primary key
#  hint          :text
#  lesson_id     :integer
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  prompt        :text
#  position      :integer
#  objective     :string(255)
#  course_id     :integer
#  question_type :string(255)
#

