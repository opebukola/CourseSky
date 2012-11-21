# == Schema Information
#
# Table name: lesson_item_skills
#
#  id             :integer          not null, primary key
#  lesson_item_id :integer
#  skill_id       :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class LessonItemSkill < ActiveRecord::Base
  attr_accessible :lesson_item_id, :skill_id

  belongs_to :lesson_item
  belongs_to :skill
end
