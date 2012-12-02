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
  #   skill_id = self.id
  #   user_id = user.id
  #   Question.find_by_sql(["SELECT DISTINCT * 
  #                     FROM questions
  #                     INNER JOIN question_skills
  #                     ON questions.id = question_skills.question_id
  #                     INNER JOIN attempts
  #                     ON questions.id = attempts.question_id
  #                     WHERE (attempts.user_id = #{user_id}
  #                       AND question_skills.skill_id = #{skill_id})"])
  # end

  #why do I have to use flatten here when it returns uniq array but
  #array(size) gives me size for all questions not unique

  def questions_attempted(user)
    user_id = user.id
    skill_id = self.id
    Question.joins(:attempts, :question_skills).where(
      "attempts.user_id = #{user_id} AND
      question_skills.skill_id = #{skill_id}").uniq.flatten
  end


  # done with ruby 
  def questions_correct(user)
    questions = self.questions_attempted(user)
    last_attempts = questions.map {
      |q| q.attempts.where(user_id: user.id).order('created_at DESC').first}
    correct_attempts = last_attempts.find_all{|a| a.correct == true}
    correct_questions = correct_attempts.map{|a| a.question}
    return correct_questions
  end

  #this method is bad because it finds correct attempts, but not last 
  #attempt. If user attempts questiont twice, gets right then wrong
  #this counts it as right but should be wrong

  def bad_questions_correct(user)
    user_id = user.id
    skill_id = self.id
    Question.joins(:attempts, :question_skills).where(
      "attempts.user_id = #{user_id} AND
      attempts.correct = true AND
      question_skills.skill_id = #{skill_id}").uniq.flatten
  end

  # def accuracy(user)
  #   self.questions_correct(user).size.to_f / 
  #   self.questions_attempted(user).size.to_f
  # end

end
