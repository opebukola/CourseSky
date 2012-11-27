# == Schema Information
#
# Table name: skills
#
#  id          :integer          not null, primary key
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  ancestry    :string(255)
#

class Skill < ActiveRecord::Base
  attr_accessible :description, :parent, :parent_id
  has_many :question_skills
  has_many :questions, through: :question_skills
  has_many :lesson_item_skills
  has_many :lesson_items, through: :lesson_item_skills
  has_many :lessons, through: :lesson_items
  has_ancestry

  scope :main, where('ancestry is null')

  # def questions_attempted_by(user)
  # 	user.attempted_questions.where("question.skills = self.id")
  # end

end
