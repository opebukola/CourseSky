# == Schema Information
#
# Table name: answers
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  correct    :boolean          default(FALSE)
#

class Answer < ActiveRecord::Base
  attr_accessible :content, :correct, :question_id
  has_many :answer_questions, dependent: :destroy
  has_many :questions, through: :answer_questions
  has_many :answer_asks, dependent: :destroy
  has_many :asks, through: :answer_asks
end
