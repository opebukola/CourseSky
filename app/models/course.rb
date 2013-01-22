# == Schema Information
#
# Table name: courses
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  cover_image :string(255)
#  description :text
#  published   :boolean          default(FALSE)
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  cover_video :string(255)
#

class Course < ActiveRecord::Base
  attr_accessible :cover_image, :description, :published, :title,
                  :cover_video
  belongs_to :user 

  has_many :units
  has_many :units, order: "position", dependent: :destroy
  has_many :lessons, through: :units
  has_many :questions, through: :lessons
  has_many :concepts, through: :lessons
  has_many :course_skills, dependent: :destroy
  has_many :skills, through: :course_skills
  has_many :enrollments, foreign_key: "enrolled_course_id", dependent: :destroy
  has_many :students, through: :enrollments

  VIDEO_REGEX = /(https?):\/\/(www.)?(youtube\.com\/watch\?v=|youtu\.be\/|youtube\.com\/watch\?feature=player_embedded&v=)([A-Za-z0-9_-]*)(\&\S+)?(\S)*/


  validates :title, presence: true
  validates :description, presence: true
  validates :user_id, presence: true
  validates :cover_video, presence: true, format: {with: VIDEO_REGEX}

  mount_uploader :cover_image, CoverImageUploader

  scope :desc, order: "created_at desc"
  scope :published, where(published: true)

  def video_source
    if VIDEO_REGEX.match(self.cover_video)
     protocol = $1
     youtube_id = $4
     video_source = "#{protocol}://www.youtube.com/embed/#{youtube_id}?rel=0&hd=1"
    else
      video_source = ""
    end
  end

  #user progress methods - need to convert to sql


  #temp method - need to write it differently
  def questions_attempted(user)
    lessons = self.lessons
    questions = lessons.map{|l| l.cfu_attempted(user)}.uniq
    return questions
  end

  def completed_lessons(user)
    lessons = self.lessons
    lessons.select{|l| l.completed_by?(user)}
  end


  def progress(user)
    total = self.lessons.size
    completed = self.completed_lessons(user).size
    progress = (completed.to_f / total.to_f) * 100
    return progress
  end

  def completed_by?(user)
    lessons = self.lessons
    lessons.all?{|l| l.completed_by(user)}
  end



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
