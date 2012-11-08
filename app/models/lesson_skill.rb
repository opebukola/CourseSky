# == Schema Information
#
# Table name: lesson_skills
#
#  id         :integer          not null, primary key
#  lesson_id  :integer
#  skill_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class LessonSkill < ActiveRecord::Base
  attr_accessible :lesson_id, :skill_id

  belongs_to :lesson
  belongs_to :skill
end
