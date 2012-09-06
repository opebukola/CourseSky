class Category < ActiveRecord::Base
  has_ancestry
  attr_accessible :name, :parent_id, :parent

  has_many :categorizations, dependent: :destroy
  has_many :courses, through: :categorizations
  has_many :children, class_name: "Category"
  belongs_to :parent, class_name: "Category"

  scope :main, where('ancestry is null')

  
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
#  ancestry   :string(255)
#

