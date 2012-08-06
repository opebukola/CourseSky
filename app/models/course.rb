class Course < ActiveRecord::Base
  attr_accessible :cover_image, :description, :published, :title,
                  :subject_id, :category_ids, :subject, :grade_level_id, :grade_level

  has_many :lessons, dependent: :destroy
  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations
  has_many :enrollments, foreign_key: "enrolled_course_id", dependent: :destroy
  has_many :students, through: :enrollments
  belongs_to :user
  belongs_to :subject
  belongs_to :grade_level

  validates :title, presence: true
  validates :description, presence: true
  validates :subject, presence: true
  validates :user_id, presence: true
  validates :grade_level, presence: true

  mount_uploader :cover_image, CoverImageUploader

  scope :desc, order: "created_at desc"
  scope :published, where(published: true)
  scope :featured, where(featured: true)

  #status methods
  def status
  	if self.published
  		return 'published'
  	else
  		return 'draft'
  	end
  end

  def feature_status
    if self.featured
      return 'featured'
    else
      return 'not featured'
    end
  end
end
# == Schema Information
#
# Table name: courses
#
#  id             :integer         not null, primary key
#  title          :string(255)
#  cover_image    :string(255)
#  description    :text
#  published      :boolean         default(FALSE)
#  user_id        :integer
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#  featured       :boolean         default(FALSE)
#  subject_id     :integer
#  grade_level_id :integer
#

