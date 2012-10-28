# == Schema Information
#
# Table name: lessons
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  document   :text
#  video_url  :string(255)
#  course_id  :integer
#  user_id    :integer
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Lesson < ActiveRecord::Base
  attr_accessible :course_id, :document, :position, :title, :user_id, :video_url

  belongs_to :user
  belongs_to :course
  has_many :lesson_items
  # has_many :questions, through: :lesson_items, source: :item, source_type: "Question"
  # has_many :videos, through: :lesson_items, source: :item, source_type: "Video"
  has_many :videos, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :comments
  has_many :question_attempts, dependent: :destroy


  acts_as_list scope: :course
  alias_method :next_lesson, :lower_item
  alias_method :prev_lesson, :higher_item


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

  def activities
    [*videos, *questions].sort_by(&:position)
  end   

end
