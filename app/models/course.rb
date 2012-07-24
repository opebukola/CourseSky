class Course < ActiveRecord::Base
  attr_accessible :cover_image, :description, :published, :title

  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true
  validates :user_id, presence: true

  mount_uploader :cover_image, CoverImageUploader

  scope :desc, order: "created_at desc"
  scope :published, where(published: true)

  #status methods
  def status
  	if self.published
  		return 'published'
  	else
  		return 'draft'
  	end
  end
end
# == Schema Information
#
# Table name: courses
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  cover_image :string(255)
#  description :text
#  published   :boolean         default(FALSE)
#  user_id     :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

