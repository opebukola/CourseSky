# == Schema Information
#
# Table name: lesson_items
#
#  id            :integer          not null, primary key
#  lesson_id     :integer
#  position      :integer
#  type          :string(255)
#  url           :string(255)
#  start_time    :integer
#  end_time      :integer
#  transcript    :text
#  question_type :string(255)
#  question_text :text
#  hint          :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Ask < LessonItem 
	attr_accessible :lesson_id, :question_type, :question_text, :hint,
									:answers_attributes
	has_many :answers, foreign_key: :lesson_item_id
	has_many :completed_asks, foreign_key: :lesson_item_id

	accepts_nested_attributes_for :answers, allow_destroy: true

	validates :question_type, presence: true
  validates :hint, presence: true


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

  #update completed_asks
  def mark_complete(user)
    self.completed_asks.find_or_create_by_student_id(
      student_id: user.id)
  end
  
  #need to figure out a way to get this count
  # def position_in_lesson(lesson)
  #   total_asks = self.lesson.asks_count
  # end

end
