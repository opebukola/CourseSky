# == Schema Information
#
# Table name: units
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  course_id  :integer
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Unit < ActiveRecord::Base
  attr_accessible :course_id, :title, :position

  belongs_to :course
  has_many :lessons

  validates :title, presence: true
  validates :course_id, presence: true

  acts_as_list	scope: :course
end
