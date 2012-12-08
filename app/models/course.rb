# == Schema Information
#
# Table name: courses
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  cover_image    :string(255)
#  description    :text
#  published      :boolean          default(FALSE)
#  user_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  featured       :boolean          default(FALSE)
#  subject_id     :integer
#  grade_level_id :integer
#

class Course < ActiveRecord::Base
  attr_accessible :cover_image, :description, :published, :title
  belongs_to :user 

  has_many :units
  has_many :units, order: "position", dependent: :destroy
  has_many :lessons, through: :units
  has_many :lesson_items, through: :lessons
  has_many :lesson_item_skills, through: :lesson_items
  has_many :skills, through: :lesson_item_skills
  has_many :enrollments, foreign_key: "enrolled_course_id", dependent: :destroy
  has_many :students, through: :enrollments

  # has_many :quizzes
  # before_destroy :ensure_no_students

  validates :title, presence: true
  validates :description, presence: true
  validates :user_id, presence: true
  # validates :grade_level, presence: true
  # validates :categories, presence: true

  mount_uploader :cover_image, CoverImageUploader

  scope :desc, order: "created_at desc"
  scope :published, where(published: true)
  # scope :featured, where(featured: true)

  #skill methods - need to convert to sql

  def practiced_skills(user)
    skills = self.skills
    skills.uniq.find_all{|s| s.questions_attempted(user).any?}
  end

  def practiced_skill_accuracy(user)
    skills = practiced_skills(user)
    skills.sort_by{|s| -s.accuracy(user)}
  end

  # def ensure_no_students
  #   if self.students
  #     self.errors.add(:base, "Cannot delete course with students")
  #     return false
  #   end
  # end

  #status methods
  def status
    if self.published
      return 'published'
    else
      return 'draft'
    end
  end

  # def feature_status
  #   if self.featured
  #     return 'featured'
  #   else
  #     return 'not featured'
  #   end
  # end

  #ratings
  def rating
    total = self.course_reviews.sum('value')
    review_count = self.course_reviews.count
    unless review_count == 0
      rating = (total / review_count).to_f
      return rating.round(1)
    end
  end

  #search
  include PgSearch
  pg_search_scope :search, against: [:title, :description],
    using: {tsearch: {dictionary: "english"}},
    associated_against: {lessons: :title}

  def self.text_search(query)
    if query.present?
      rank = <<-RANK
      ts_rank(to_tsvector(title), plainto_tsquery(#{sanitize(query)}))
    RANK
  where("title @@ :q or description @@ :q", q: "%#{query}%").order("#{rank} DESC")
      search(query).order("#{rank} desc")
    else
      scoped
    end
  end
end
