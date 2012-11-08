# == Schema Information
#
# Table name: attempts
#
#  id          :integer          not null, primary key
#  started_at  :datetime
#  ended_at    :datetime
#  correct     :boolean
#  question_id :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Attempt < ActiveRecord::Base
  attr_accessible :correct, :ended_at, :question_id, :started_at, :user_id

  belongs_to :user
  belongs_to :question

  # after_save :update_user_score

  # def update_user_score
  # 	self.user.update_score!
  # end
end
