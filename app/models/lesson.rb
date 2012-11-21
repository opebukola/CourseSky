# == Schema Information
#
# Table name: lessons
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  document   :text
#  course_id  :integer
#  user_id    :integer
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Lesson < ActiveRecord::Base
  attr_accessible :course_id, :document, :position, :title, :user_id, :skill_ids

  belongs_to :user
  belongs_to :course
  has_many :comments
  has_many :lesson_items, order: :position
  # has_many :lesson_skills
  # has_many :skills, through: :lesson_skills
  has_many :lesson_questions
  has_many :questions, through: :lesson_questions
  has_many :lesson_item_skills, through: :lesson_items
  has_many :skills, through: :lesson_item_skills


  acts_as_list scope: :course
  alias_method :next_lesson, :lower_item
  alias_method :prev_lesson, :higher_item

  validates :title, presence: true
  validates :user_id, presence: true
  validates :course_id, presence: true



  def asks_count
    self.lesson_items.find_all_by_type('Ask').count
  end 

end
