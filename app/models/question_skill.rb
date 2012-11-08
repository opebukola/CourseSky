# == Schema Information
#
# Table name: question_skills
#
#  id          :integer          not null, primary key
#  question_id :integer
#  skill_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class QuestionSkill < ActiveRecord::Base
  attr_accessible :question_id, :skill_id
  belongs_to :question
  belongs_to :skill
end
