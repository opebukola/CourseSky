# == Schema Information
#
# Table name: answers
#
#  id             :integer          not null, primary key
#  content        :string(255)
#  lesson_item_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  correct        :boolean          default(FALSE)
#

class Answer < ActiveRecord::Base
  attr_accessible :content, :correct, :question_id
  belongs_to :lesson_item
end
