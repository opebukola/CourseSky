# == Schema Information
#
# Table name: lesson_activities
#
#  id            :integer          not null, primary key
#  position      :integer
#  lesson_id     :integer
#  activity_type :string(255)
#  activity_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class LessonActivity < ActiveRecord::Base
  attr_accessible :activity_id, :activity_type, :position

  belongs_to :lesson
  belongs_to :activity, polymorphic: true

  validates :lesson_id, presence: true
  validates :activity_id, presence: true
  validates :activity_type, presence: true

  acts_as_list scope: :lesson
  alias_method :next_item, :lower_item
  alias_method :prev_item, :higher_item
end
