# == Schema Information
#
# Table name: quizzes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  course_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Quiz < ActiveRecord::Base
  attr_accessible :course_id, :skill_ids

  belongs_to :user
  belongs_to :course
  has_many :skill_listings, as: :skilled
  has_many :skills, through: :skill_listings

  def questions
  	skills = self.skills
  	skills.map {|skill| skill.questions }
  end
end
