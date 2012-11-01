# == Schema Information
#
# Table name: completed_asks
#
#  id             :integer          not null, primary key
#  student_id     :integer          not null
#  lesson_item_id :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

class CompletedAskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
