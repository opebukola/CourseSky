# == Schema Information
#
# Table name: lessons
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  document   :text
#  unit_id    :integer
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Lesson < ActiveRecord::Base
  attr_accessible :unit_id, :document, :position, :title,:skill_ids

  belongs_to :unit
  has_many :questions
  has_many :concepts
  has_many :concept_skills, through: :concepts
  has_many :skills, through: :concept_skills
  has_one :course, through: :unit
  has_many :lesson_activities, order: :position
  has_many :comments

  validates :title, presence: true
  validates :unit_id, presence: true

  acts_as_list scope: :unit
  alias_method :next_lesson, :lower_item
  alias_method :prev_lesson, :higher_item

  def cfu_activities
    self.lesson_activities.find_all_by_activity_type('Question')
  end

  # find cfu questions only - sql & test
  def cfu_questions
    self.cfu_activities.map{|a| Question.find(a.activity_id)}.flatten
  end


  #lesson progress methods - need to test  & sql

  def cfu_correct(user)
    self.cfu_questions.select{|q| q.correct_attempt?(user)}
  end

  def progress(user)
    total = self.cfu_questions.count
    correct = self.cfu_correct(user).count
    progress = (correct.to_f / total.to_f) * 100
    return progress
  end

  def completed_by?(user)
    return true if self.cfu_questions.all?{|q| q.correct_attempt?(user)}
  end 

end
