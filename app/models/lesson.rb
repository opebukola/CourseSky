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
  has_many :comments
  has_many :lesson_items, order: :position
  has_many :lesson_questions
  has_many :questions, through: :lesson_questions
  has_many :lesson_item_skills, through: :lesson_items
  has_many :skills, through: :lesson_item_skills
  has_one :course, through: :unit

  validates :title, presence: true
  validates :unit_id, presence: true

  acts_as_list scope: :unit
  alias_method :next_lesson, :lower_item
  alias_method :prev_lesson, :higher_item

  def asks_count
    self.lesson_items.find_all_by_type('Ask').count
  end 

end
