# == Schema Information
#
# Table name: course_skills
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  skill_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CourseSkill < ActiveRecord::Base
  # attr_accessible :course_id, :skill_id
  belongs_to :course
  belongs_to :skill
end
