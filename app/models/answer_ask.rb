# == Schema Information
#
# Table name: answer_asks
#
#  id         :integer          not null, primary key
#  answer_id  :integer
#  ask_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class AnswerAsk < ActiveRecord::Base
  attr_accessible :answer_id, :ask_id
  belongs_to :answer
  belongs_to :ask
end
