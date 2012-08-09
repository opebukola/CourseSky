class CourseReview < ActiveRecord::Base
  attr_accessible :content, :course_id, :value

  belongs_to :user
  belongs_to :course

  validates :value, presence: true
  validates :course_id, presence: true
  validates :user_id, presence: true
  validates_uniqueness_of :course_id, scope: :user_id
  validates_inclusion_of :value, in: [1,2,3,4,5]
end
# == Schema Information
#
# Table name: course_reviews
#
#  id         :integer         not null, primary key
#  course_id  :integer
#  user_id    :integer
#  content    :text
#  value      :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

