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

class LessonItem < ActiveRecord::Base
  attr_accessible :url, :start_time, :end_time, :transcript, :lesson_id,
  								:type, :question_text, :question_type, :hint, :skill_ids
  belongs_to :lesson
  has_many :lesson_item_skills
  has_many :skills, through: :lesson_item_skills
  has_one :lesson_activity, as: :activity

  acts_as_list scope: :lesson
  alias_method :next_item, :lower_item
  alias_method :prev_item, :higher_item

  validates :lesson_id, presence: true
  validate :must_have_skills
  after_create :create_lesson_activity
  before_destroy :delete_lesson_activity

  def create_lesson_activity
    activity = self.lesson.lesson_activities.new
    activity.activity_id = self.id
    activity.activity_type = 'LessonItem'
    activity.save
  end

  def delete_lesson_activity
    LessonActivity.find_by_lesson_id_and_activity_id_and_activity_type(
      self.lesson.id, self.id, 'LessonItem').destroy
  end

  def must_have_skills
  	errors.add(:lesson_item, 'must have at least one skill') if self.skills.empty?
  end

end
