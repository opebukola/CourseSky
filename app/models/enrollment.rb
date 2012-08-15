class Enrollment < ActiveRecord::Base
  attr_accessible :enrolled_course_id, :student_id
  belongs_to :student, class_name: "User"
  belongs_to :enrolled_course, class_name: "Course"

  after_save :build_lesson_progressions
  before_destroy :delete_lesson_progressions

  private
  	def build_lesson_progressions
  		self.enrolled_course.lessons.each do |lesson|
  			lesson.lesson_progressions.create!(
  										enrolled_lesson_id: lesson.id,
  										student_id: self.student_id,
  										enrolled_course_id: self.enrolled_course_id)
  		end
  	end

    def delete_lesson_progressions
      progressions = LessonProgression.where('enrolled_course_id = ?
                      AND student_id = ?', self.enrolled_course_id,
                      self.student_id)
      progressions.delete_all
    end
end
# == Schema Information
#
# Table name: enrollments
#
#  id                 :integer         not null, primary key
#  student_id         :integer
#  enrolled_course_id :integer
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#

