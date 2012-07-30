class Question < ActiveRecord::Base
  attr_accessible :content, :hint, :lesson_id, :answers_attributes
  belongs_to :lesson
  has_many :answers

  accepts_nested_attributes_for :answers, allow_destroy: true

  def correct_answers
  	answer_array = []
    self.answers.each do |answer|
  		answer.content
  		answer_array<<answer.content
  	end
  	return answer_array
  end

end
# == Schema Information
#
# Table name: questions
#
#  id         :integer         not null, primary key
#  content    :text
#  hint       :text
#  lesson_id  :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

