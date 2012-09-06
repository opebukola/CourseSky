class QuestionAttempt < ActiveRecord::Base
  attr_accessible :completed, :question_id, :student_id

  belongs_to :student, class_name: "User"
  belongs_to :question

  validates :question_id, presence:true
  validates :student_id, presence: true

  validates_uniqueness_of :student_id, scope: :question_id
end
# == Schema Information
#
# Table name: question_attempts
#
#  id          :integer         not null, primary key
#  student_id  :integer
#  question_id :integer
#  completed   :boolean         default(FALSE)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

