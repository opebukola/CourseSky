# == Schema Information
#
# Table name: questions
#
#  id            :integer          not null, primary key
#  hint          :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  question_type :string(255)
#  explanation   :text
#  question_text :text
#  difficulty    :integer
#

class Question < ActiveRecord::Base
  attr_accessible :answers_attributes, :question_type, :explanation, :difficulty, 
                  :hint, :question_text, :skill_ids, :lesson_ids
  has_many :question_skills
  has_many :skills, through: :question_skills
  has_many :answer_questions, dependent: :destroy
  has_many :answers, through: :answer_questions
  has_many :attempts, dependent: :destroy
  has_many :lesson_questions
  has_many :lessons, through: :lesson_questions

  QUESTION_TYPES = ["Multiple Choice", "Enter Response"]
  QUESTION_DIFFICULTY = [1, 2, 3, 4, 5]


  accepts_nested_attributes_for :answers, allow_destroy: true

  validates :question_type, presence: true
  validates :question_text, presence: true
  validates :hint, presence: true
  validates :answers, presence: true
  validates :difficulty, presence: true
  validate :must_have_skills

  #quiz methods

  def last_quiz_attempt(quiz)
    quiz.attempts.where(question_id: self.id).order('created_at DESC').first
  end

  #user methods

  def all_attempts_by(user)
    Attempt.where(
      question_id: self.id, user_id: user.id)
  end

  def last_attempt_by(user)
    Attempt.where(
      question_id: self.id, user_id: user.id).order('
      created_at DESC').first
  end




  def must_have_skills
    errors.add(:question, 'must have at least one skill') if self.skills.empty?
  end

  def is_multiple_choice?
    return true if self.question_type == "Multiple Choice"
  end

  def correct_answers
    answer_array = []
    self.answers.find_all_by_correct(:true).each do |answer|
      answer_array<<answer.content.downcase
    end
    return answer_array
  end

  def is_correct?(response)
    self.correct_answers.include?(response.downcase)
  end

  def possible_points
    20 * self.difficulty
  end

  # #quiz methods
  # def last_in_quiz?(quiz)
  #   return true if quiz.questions.last.id == self.id
  # end
end
