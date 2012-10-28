# == Schema Information
#
# Table name: questions
#
#  id            :integer          not null, primary key
#  hint          :text
#  lesson_id     :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  position      :integer
#  question_type :string(255)
#  explanation   :text
#  question_text :text
#

class Question < ActiveRecord::Base
  attr_accessible :lesson_id, :answers_attributes, :question_type, 
                  :explanation, :hint, :question_text
  belongs_to :lesson
  has_many :answers
  has_many :completed_questions, dependent: :destroy

  acts_as_list scope: :lesson
  alias_method :next_question, :lower_item
  alias_method :prev_question, :higher_item

  accepts_nested_attributes_for :answers, allow_destroy: true

  validates :lesson_id, presence: true
  validates :question_type, presence: true
  validates :hint, presence: true
  validates :explanation, presence: true


  #question types
  QUESTION_TYPES = ["Multiple Choice", "Enter Response", "Open Ended"]

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

  #update completed_questions
  def mark_correct(user)
    self.completed_questions.find_or_create_by_student_id(
      student_id: user.id)
  end
end
