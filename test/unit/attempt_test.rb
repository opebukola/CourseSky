# == Schema Information
#
# Table name: attempts
#
#  id          :integer          not null, primary key
#  started_at  :datetime
#  ended_at    :datetime
#  correct     :boolean
#  question_id :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class AttemptTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
