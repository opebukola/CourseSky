class Enrollment < ActiveRecord::Base
  attr_accessible :enrolled_course_id, :student_id
  belongs_to :student, class_name: "User"
  belongs_to :enrolled_course, class_name: "Course"
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

