# == Schema Information
#
# Table name: attempts
#
#  id          :integer          not null, primary key
#  started_at  :datetime
#  ended_at    :datetime
#  correct     :boolean          default(FALSE)
#  question_id :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  response    :string(255)
#  quiz_id     :integer
#

class Attempt < ActiveRecord::Base
  attr_accessible :correct, :ended_at, :question_id, :started_at, :user_id,
  								:response, :quiz_id

  belongs_to :user
  belongs_to :question
  belongs_to :quiz

  validates :user_id, presence: true
  validates :question_id, presence: true
  validates :quiz_id, presence: true
  scope :skipped, where('response is null')

  def status
    if self.correct 
      return 'Correct'
    else
      return 'Incorrect'
    end
  end

  # after_save :update_user_score

  # def update_user_score
  # 	self.user.update_score!
  # end
end
