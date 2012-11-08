# == Schema Information
#
# Table name: answer_questions
#
#  id          :integer          not null, primary key
#  answer_id   :integer
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class AnswerQuestion < ActiveRecord::Base
  attr_accessible :answer_id, :question_id
  belongs_to :answer
  belongs_to :question
end
