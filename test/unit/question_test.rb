# == Schema Information
#
# Table name: questions
#
#  id            :integer          not null, primary key
#  first_hint    :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  position      :integer
#  question_type :string(255)
#  explanation   :text
#  question_text :text
#  second_hint   :text
#

require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
