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

  # def questions_attempted(user)
  #   user_id = user.id
  #   skill_id = self.id
  #   Question.find_by_sql(["SELECT * 
  #                 FROM questions
  #                 INNER JOIN question_skills
  #                 ON question.id = question_skill.question_id
  #                 INNER JOIN attempts
  #                 ON question.id = attempt.question_id 
  #                 WHERE(attempt.user_id = #{user_id}
  #                   AND question_skill.skill_id = #{skill_id})"])
  # end

  # this is terrible. need to use sql
  def questions_attempted(user)
    questions = self.questions
    attempts = questions.map {|q| q.attempts }
    user_attempts = attempts.flatten.find_all{|a| a.user_id == user.id}
    user_questions = user_attempts.map{|a| a.question }
  end

end
