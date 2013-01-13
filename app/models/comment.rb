# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  content    :text
#  ancestry   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  concept_id :integer
#

class Comment < ActiveRecord::Base
  has_ancestry
  attr_accessible :content, :concept_id, :parent_id
  belongs_to :user
  belongs_to :concept

  validates :user_id, presence: true
  validates :content, presence: true
  validates :concept_id, presence: true

end
