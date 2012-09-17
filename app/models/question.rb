class Question < ActiveRecord::Base
  attr_accessible :hint, :lesson_id, :answers_attributes, :prompt,
                  :objective, :course_id, :question_type
  belongs_to :lesson
  belongs_to :course
  has_many :answers
  has_many :question_attempts, dependent: :destroy
  before_save :set_position

  accepts_nested_attributes_for :answers, allow_destroy: true

  validates :lesson_id, presence: true
  validates :course_id, presence: true
  validates :prompt, presence: true
  validates :objective, presence: true

  #method for doing multiple choice 
  QUESTION_TYPES = ["Multiple Choice", "Free Response"]

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

  # Record answer attempt
  def update_attempts(user)
    try = self.question_attempts.find_or_create_by_student_id(
      student_id:user.id)
    attempt_count = try.attempts
    try.update_attribute(:attempts, attempt_count += 1)
  end

  #update correct
  def mark_correct(user)
    attempt = QuestionAttempt.find_by_question_id_and_student_id(self.id, user.id)
    attempt.update_attribute(:completed, true)
  end


  #find next question in the course

  def next_question
    Question.order(:position).find(:first, conditions: ["position > ? and course_id = ?",
        self.position, self.course_id]) 
  end

  protected
    def set_position
      self.position ||= 1 + (Question.where('course_id=?',course_id).maximum(:position) || 0)
    end

end
# == Schema Information
#
# Table name: questions
#
#  id            :integer         not null, primary key
#  hint          :text
#  lesson_id     :integer
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  prompt        :text
#  position      :integer
#  objective     :string(255)
#  course_id     :integer
#  question_type :string(255)
#

