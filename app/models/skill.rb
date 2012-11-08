# == Schema Information
#
# Table name: skills
#
#  id          :integer          not null, primary key
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Skill < ActiveRecord::Base
  attr_accessible :description
  has_many :lesson_skills
  has_many :lessons, through: :lesson_skills
  has_many :question_skills
  has_many :questions, through: :question_skills
  has_many :quiz_skills
  has_many :quizzes, through: :quiz_skills
end
