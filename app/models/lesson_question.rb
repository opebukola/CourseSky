# == Schema Information
#
# Table name: lesson_questions
#
#  id          :integer          not null, primary key
#  lesson_id   :integer
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class LessonQuestion < ActiveRecord::Base
  attr_accessible :lesson_id, :question_id

  belongs_to :lesson
  belongs_to :question
end
