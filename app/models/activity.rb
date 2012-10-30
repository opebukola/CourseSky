# == Schema Information
#
# Table name: activities
#
#  id                   :integer          not null, primary key
#  lesson_id            :integer
#  lesson_position      :integer
#  lesson_activity_id   :integer
#  lesson_activity_type :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class Activity < ActiveRecord::Base
  attr_accessible :lesson_id, :lesson_activity_id, :lesson_activity_type

  belongs_to :lesson
  belongs_to :lesson_activity, polymorphic: true

  acts_as_list scope: :lesson, :column => 'lesson_position'
end
