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
  has_many :concept_skills
  has_many :concepts, through: :concept_skills
  has_many :lessons, through: :concepts
  has_many :course_skills, dependent: :destroy
  has_many :courses, through: :course_skills
 
  has_ancestry

  scope :main, where('ancestry is null')

  #why do I have to use flatten here when it returns uniq array but
  #array(size) gives me size for all questions not unique

  def questions_attempted(user)
    user_id = user.id
    skill_id = self.id
    Question.joins(:attempts, :question_skills).where(
      attempts: {user_id: user_id},
      question_skills: {skill_id: skill_id}).uniq
  end

  def questions_correct(user)
    user_id = user.id
    skill_id = self.id
    Question.where(
      "(SELECT correct FROM attempts 
        WHERE question_id = questions.id 
        ORDER BY created_at DESC LIMIT 1) = true").joins(:attempts, :question_skills).where(
    attempts: {user_id: user_id},
    question_skills: {skill_id: skill_id}).uniq

  end


  def accuracy(user)
    self.questions_correct(user).flatten.size.to_f / 
    self.questions_attempted(user).flatten.size.to_f
  end

end
