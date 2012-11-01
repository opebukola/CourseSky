# == Schema Information
#
# Table name: lesson_items
#
#  id            :integer          not null, primary key
#  lesson_id     :integer
#  position      :integer
#  type          :string(255)
#  url           :string(255)
#  start_time    :integer
#  end_time      :integer
#  transcript    :text
#  question_type :string(255)
#  question_text :text
#  hint          :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class LessonItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
