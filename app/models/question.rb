# == Schema Information
#
# Table name: questions
#
#  id            :integer          not null, primary key
#  first_hint    :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  position      :integer
#  question_type :string(255)
#  explanation   :text
#  question_text :text
#  second_hint   :text
#

class Question < ActiveRecord::Base
  attr_accessible :answers_attributes, :question_type, :explanation, 
                  :first_hint, :question_text, :skill_ids, :lesson_ids
  has_many :question_skills
  has_many :skills, through: :question_skills
  has_many :answer_questions, dependent: :destroy
  has_many :answers, through: :answer_questions
  has_many :attempts, dependent: :destroy
  has_many :lesson_questions
  has_many :lessons, through: :lesson_questions



  # acts_as_list scope: :lesson
  # alias_method :next_question, :lower_item
  # alias_method :prev_question, :higher_item

  accepts_nested_attributes_for :answers, allow_destroy: true

  validates :question_type, presence: true
  # validates :explanation, presence: true
  # validate :must_have_answers


  #question types
  QUESTION_TYPES = ["Multiple Choice", "Enter Response"]

  def must_have_answers
    errors.add(:base, "Must have at least one answer") if self.answers.empty?
  end


  def is_multiple_choice?
    return true if self.question_type == "Multiple Choice"
  end

  def correct_answers
    if self.answers.any?
      answer_array = []
      self.answers.find_all_by_correct(:true).each do |answer|
        answer_array<<answer.content.downcase
      end
      return answer_array
    end
  end

  def no_answer
    self.answers.empty?
  end

  def is_correct?(response)
    self.no_answer || self.correct_answers.include?(response.downcase)
  end

  #update attempts
  def mark_correct(user, response)
    self.attempts.create(user_id: user.id, 
                        response: response,
                        correct: true)
  end

  def mark_incorrect(user, response)
    self.attempts.create(user_id: user.id,
                        response: response)
  end

  #quiz methods
  def last_in_quiz?(quiz)
    return true if quiz.questions.last.id == self.id
  end
end
