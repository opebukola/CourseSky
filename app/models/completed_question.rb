# == Schema Information
#
# Table name: completed_questions
#
#  id          :integer          not null, primary key
#  student_id  :integer          not null
#  question_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class CompletedQuestion < ActiveRecord::Base
  attr_accessible :student_id, :question_id
  belongs_to :student, class_name: "User"
  belongs_to :question
  after_save :build_course_enrollment

  validates :question_id, presence:true
  validates :student_id, presence: true

  protected

    def build_course_enrollment
      course = self.question.lesson.course
      user = self.student
      unless course.user == user
        Enrollment.find_or_create_by_student_id_and_enrolled_course_id(
        self.student_id, course.id)
      end
    end
end
