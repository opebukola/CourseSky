class GradeLevel < ActiveRecord::Base
  attr_accessible :name

  has_many :courses
end
# == Schema Information
#
# Table name: grade_levels
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

