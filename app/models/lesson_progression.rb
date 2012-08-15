class LessonProgression < ActiveRecord::Base
  attr_accessible :completed, :enrolled_course_id, :enrolled_lesson_id, :student_id

  belongs_to :student, class_name: "User"
  belongs_to :enrolled_lesson, class_name: "Lesson"

  validates_uniqueness_of :student_id, scope: [:enrolled_course_id, :enrolled_lesson_id]

  scope :completed, where(completed:true)

end
# == Schema Information
#
# Table name: lesson_progressions
#
#  id                 :integer         not null, primary key
#  student_id         :integer
#  enrolled_course_id :integer
#  enrolled_lesson_id :integer
#  completed          :boolean         default(FALSE)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#

