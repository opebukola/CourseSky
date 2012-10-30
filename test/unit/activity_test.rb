# == Schema Information
#
# Table name: activities
#
#  id                   :integer          not null, primary key
#  lesson_id            :integer
#  lesson_position      :integer
#  lesson_activity_id   :integer
#  lesson_activity_type :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

require 'test_helper'

class ActivityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
