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
#  first_hint    :text
#  lesson_id     :integer
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  position      :integer
#  course_id     :integer
#  question_type :string(255)
#  prompt        :text
#  explanation   :text
#  second_hint   :text
#  content       :boolean         default(FALSE)
#  question_text :text
#

