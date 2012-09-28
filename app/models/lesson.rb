class Lesson < ActiveRecord::Base
  before_save :set_position
  attr_accessible :course_id, :document, :document_ipaper_access_key, :document_ipaper_id, :position, 
                  :title, :user_id, :video_url, :intro

  belongs_to :user
  belongs_to :course
  has_many :questions, dependent: :destroy
  has_many :comments
  has_many :question_attempts, dependent: :destroy


  mount_uploader :document, DocumentUploader

  VIDEO_REGEX = /(https?):\/\/(www.)?(youtube\.com\/watch\?v=|youtu\.be\/|youtube\.com\/watch\?feature=player_embedded&v=)([A-Za-z0-9_-]*)(\&\S+)?(\S)*/
  validates :video_url, format: {with: VIDEO_REGEX}, allow_blank: true

  validates :title, presence: true
  validates :user_id, presence: true
  validates :course_id, presence: true

  #create embed codes for Youtube Video URLs. Need to do embed codes
  def video_source
    regex_youtube = /(https?):\/\/(www.)?(youtube\.com\/watch\?v=|youtu\.be\/|youtube\.com\/watch\?feature=player_embedded&v=)([A-Za-z0-9_-]*)(\&\S+)?(\S)*/
    if regex_youtube.match(self.video_url)
      protocol = $1
      youtube_id = $4
      video_source = "#{protocol}://www.youtube.com/embed/#{youtube_id}"
    else
      video_source = ""
    end
  end

  def first_lesson?
    self.position == 1
  end

  def last_lesson?
    self.position == self.course.lessons.count
  end

  def next_lesson
    self.course.lessons.find_by_position(self.position + 1)
  end

  def prev_lesson
    self.course.lessons.find_by_position(self.position - 1)
  end

  protected
    def set_position
      self.position ||= 1 + (self.course.lessons.maximum(:position) || 0)
    end
end
# == Schema Information
#
# Table name: lessons
#
#  id                         :integer         not null, primary key
#  title                      :string(255)
#  document                   :string(255)
#  video_url                  :string(255)
#  course_id                  :integer
#  user_id                    :integer
#  document_ipaper_id         :integer
#  document_ipaper_access_key :string(255)
#  position                   :integer
#  created_at                 :datetime        not null
#  updated_at                 :datetime        not null
#  intro                      :text
#

