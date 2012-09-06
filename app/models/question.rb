class Question < ActiveRecord::Base
  attr_accessible :content, :hint, :lesson_id, :answers_attributes, :prompt,
                  :objective
  belongs_to :lesson
  has_many :answers
  before_save :set_position

  accepts_nested_attributes_for :answers, allow_destroy: true

  scope :positioned, order: "position"

  def has_answer?
    self.answers.any?
  end

  def correct_answers
    if self.answers.any?
    	answer_array = []
      self.answers.each do |answer|
    		answer_array<<answer.content.downcase
    	end
    	return answer_array
    end
  end

  # If student gives correct answer, create a question attempt
  def mark_complete(user)
    QuestionAttempt.create!(question_id:self.id, student_id:user.id)
  end

  #find next question
  def next_question
    Question.order(:position).find(:first, conditions: ["position > ? and lesson_id = ?",
        self.position, self.lesson_id])
  end

  protected
    def set_position
      self.position ||= 1 + (Question.where('lesson_id=?',lesson_id).maximum(:position) || 0)
    end

end
# == Schema Information
#
# Table name: questions
#
#  id         :integer         not null, primary key
#  content    :text
#  hint       :text
#  lesson_id  :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  prompt     :text
#  position   :integer
#  objective  :string(255)
#

