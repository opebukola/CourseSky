class QuestionAttempt < ActiveRecord::Base
  attr_accessible :completed, :question_id, :student_id

  belongs_to :student, class_name: "User"
  belongs_to :question
  belongs_to :lesson
  before_save :set_lesson_id
  after_save :build_course_enrollment

  validates :question_id, presence:true
  validates :student_id, presence: true
  validates :lesson_id, presence: true

  validates_uniqueness_of :student_id, scope: :question_id

  protected
    def set_lesson_id
      self.lesson_id = self.question.lesson.id
    end

    def build_course_enrollment
      course = self.lesson.course
      user = self.student
      unless course.user == user
        Enrollment.find_or_create_by_student_id_and_enrolled_course_id(
        self.student_id, self.lesson.course_id)
      end
    end
end
# == Schema Information
#
# Table name: question_attempts
#
#  id          :integer         not null, primary key
#  student_id  :integer
#  question_id :integer
#  completed   :boolean         default(FALSE)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  attempts    :integer         default(0)
#  lesson_id   :integer
#

