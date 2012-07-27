class Categorization < ActiveRecord::Base
  attr_accessible :category_id, :course_id
  belongs_to :category
  belongs_to :course
end
# == Schema Information
#
# Table name: categorizations
#
#  id          :integer         not null, primary key
#  category_id :integer
#  course_id   :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

