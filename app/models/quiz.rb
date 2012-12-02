# == Schema Information
#
# Table name: quizzes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  lesson_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  course_id  :integer
#

class Quiz < ActiveRecord::Base
  attr_accessible :lesson_id, :course_id, :skill_ids

  belongs_to :user
  belongs_to :lesson
  belongs_to :course
  has_many :available_questions, through: :lesson, source: :questions
  has_many :skills, through: :questions
  has_many :attempts
  has_many :attempted_questions, through: :attempts, source: :question

  validates :user_id, presence: true
  validates :course_id, presence: true
  validates :lesson_id, presence: true

  def final_attempts
    questions = self.attempted_questions.uniq{|q| q.id}
    questions.map{|q| q.last_quiz_attempt(self)}
  end

  def correct_questions
    attempts = self.final_attempts
    attempts.select{|a| a.correct}.count
  end

  def incorrect_questions
    total = self.final_attempts.count
    return total - self.correct_questions
  end

  def score
    if self.attempts
      correct = self.correct_questions.to_f
      incorrect = self.incorrect_questions.to_f
      return correct / (correct + incorrect) * 100
    end
  end

  def total_points_earned
    score_array = self.final_attempts.map{
      |attempt| attempt.calculate_score
    }
    score_array.reduce(:+)
  end

end
