require 'test_helper'

class EnrolledLessonsTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
# == Schema Information
#
# Table name: enrolled_lessons
#
#  id                 :integer         not null, primary key
#  student_id         :integer
#  enrolled_course_id :integer
#  enrolled_lesson_id :integer
#  completed          :boolean         default(FALSE)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#

