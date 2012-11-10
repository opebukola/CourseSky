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
  validate :question_count

  def question_count
    self.questions.count == 3
  end



  def correct_questions
    attempts = self.questions.each do |question|
      question.attempts.find_all_by_correct(true)
    end
    return attempts.count
  end

  def incorrect_questions
    total = self.questions.count
    return total - self.correct_questions
  end

  def score
    return (self.correct_questions / self.questions.count)*100
  end

end
