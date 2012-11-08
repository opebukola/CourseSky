# == Schema Information
#
# Table name: quizzes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  course_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Quiz < ActiveRecord::Base
  attr_accessible :course_id, :skill_ids

  belongs_to :user
  belongs_to :course
  has_many :quiz_skills
  has_many :skills, through: :quiz_skills
  has_many :question_skills, through: :skills
  has_many :questions, through: :question_skills
  # quiz->(quiz_skills)->skills->(question_skills)->questions

  # def questions
  # 	skills = self.skills
  # 	skills.map {|skill| skill.questions }.flatten
  # end

end
