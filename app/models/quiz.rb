# == Schema Information
#
# Table name: quizzes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  lesson_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Quiz < ActiveRecord::Base
  attr_accessible :lesson_id, :skill_ids

  belongs_to :user
  belongs_to :lesson
  # has_many :quiz_skills
  # has_many :skills, through: :quiz_skills
  # has_many :question_skills, through: :skills
  # has_many :questions, through: :question_skills
  has_many :available_questions, through: :lesson, source: :questions
  has_many :skills, through: :questions
  has_many :attempts
  has_many :attempted_questions, through: :attempts, source: :question

  def unique_questions_attempted
    self.attempted_questions.uniq{ |question| question.id}
  end

  def unique_question_attempts
    self.attempts.reverse.uniq!{ |attempt| attempt.question }
  end


  def correct_questions
    self.attempts.find_all_by_correct(true).count
  end

  def incorrect_questions
    total = self.attempts.count
    return total - self.correct_questions
  end

  def score
    correct = self.correct_questions.to_f
    incorrect = self.incorrect_questions.to_f
    total = correct + incorrect
    return (correct / total) * 100
  end

end
