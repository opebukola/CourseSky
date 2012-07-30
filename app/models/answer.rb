class Answer < ActiveRecord::Base
  attr_accessible :content, :correct_answer, :question_id
  belongs_to :question
end
# == Schema Information
#
# Table name: answers
#
#  id          :integer         not null, primary key
#  content     :string(255)
#  question_id :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

