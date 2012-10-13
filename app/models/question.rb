class Question < ActiveRecord::Base
  attr_accessible :lesson_id, :answers_attributes, :prompt,
                   :course_id, :question_type, :explanation, 
                   :hint, :content, :question_text,
                   :video_start, :video_end, :snippet
  belongs_to :lesson
  belongs_to :course
  has_many :answers
  has_many :question_attempts, dependent: :destroy

  acts_as_list scope: :lesson
  alias_method :next_question, :lower_item
  alias_method :prev_question, :higher_item

  accepts_nested_attributes_for :answers, allow_destroy: true

  validates :lesson_id, presence: true
  validates :course_id, presence: true
  validates :prompt, presence: true
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

  #build video clip
  def video_clip_source
    video_source = self.lesson.video_source
    start_time = self.video_start
    end_time = self.video_end
    return video_source + "?&start=" + start_time.to_s + 
    "&end=" + end_time.to_s
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
#  position      :integer
#  course_id     :integer
#  question_type :string(255)
#  prompt        :text
#  explanation   :text
#  content       :boolean         default(FALSE)
#  question_text :text
#  video_start   :integer
#  video_end     :integer
#  snippet       :text
#

