class Comment < ActiveRecord::Base
  has_ancestry
  attr_accessible :content, :lesson_id, :parent_id

  belongs_to :user
  belongs_to :lesson

  validates :user_id, presence: true
  validates :lesson_id, presence: true
  validates :content, presence: true

end
# == Schema Information
#
# Table name: comments
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  lesson_id  :integer
#  content    :text
#  ancestry   :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

