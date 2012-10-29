# == Schema Information
#
# Table name: skills
#
#  id          :integer          not null, primary key
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Skill < ActiveRecord::Base
  attr_accessible :description
  has_many :skill_listings
  has_many :lessons, through: :skill_listings, source: :skilled, source_type: 'Lesson'
  has_many :questions, through: :skill_listings, source: :skilled, source_type: 'Question'
  has_many :quizzes, through: :skill_listings, source: :skilled, source_type: 'Quiz'
end
