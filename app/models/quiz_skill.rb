# == Schema Information
#
# Table name: quiz_skills
#
#  id         :integer          not null, primary key
#  quiz_id    :integer
#  skill_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class QuizSkill < ActiveRecord::Base
  attr_accessible :quiz_id, :skill_id
  belongs_to :quiz
  belongs_to :skill
end
