# == Schema Information
#
# Table name: questions
#
#  id            :integer          not null, primary key
#  hint          :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  question_type :string(255)
#  explanation   :text
#  question_text :text
#  difficulty    :integer
#

require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
