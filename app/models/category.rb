class Category < ActiveRecord::Base
  attr_accessible :name, :subject_id

  has_many :categorizations, dependent: :destroy
  has_many :courses, through: :categorizations
  belongs_to :subject
end
# == Schema Information
#
# Table name: categories
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  subject_id :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

