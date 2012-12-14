# == Schema Information
#
# Table name: concepts
#
#  id          :integer          not null, primary key
#  lesson_id   :integer
#  video_url   :string(255)
#  video_start :integer
#  video_end   :integer
#  doc         :text
#  title       :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Concept < ActiveRecord::Base
  attr_accessible :doc, :lesson_id, :video_end, :video_start, :video_url, :title,
                  :skill_ids

  belongs_to :lesson
  has_one :lesson_activity, as: :activity
  has_many :concept_skills
  has_many :skills, through: :concept_skills

  VIDEO_REGEX = /(https?):\/\/(www.)?(youtube\.com\/watch\?v=|youtu\.be\/|youtube\.com\/watch\?feature=player_embedded&v=)([A-Za-z0-9_-]*)(\&\S+)?(\S)*/

  validates :lesson_id, presence: true
  validates	:title, presence: true
  validates :video_url, presence: true, format: {with: VIDEO_REGEX}
  validates :doc, presence: true
  validate :must_have_skills
  after_create :create_lesson_activity
  before_destroy :delete_lesson_activity

  def must_have_skills
  	errors.add(:concept, 'must have at least one skill') if self.skills.empty?
  end

  def create_lesson_activity
    activity = self.lesson.lesson_activities.new
    activity.activity_id = self.id
    activity.activity_type = 'Concept'
    activity.save
  end

  def delete_lesson_activity
    LessonActivity.find_by_lesson_id_and_activity_id_and_activity_type(
      self.lesson.id, self.id, 'Concept').destroy
  end

  #create embed code for Youtube video URLS
  def video_source
    regex_youtube = VIDEO_REGEX
    if regex_youtube.match(self.video_url)
      protocol = $1
      youtube_id = $4
      video_source = "#{protocol}://www.youtube.com/embed/#{youtube_id}?rel=0&hd=1"
    else
      video_source = ""
    end
  end

  def video_clip_source
    video_source = self.video_source
    start_time = self.video_start
    end_time = self.video_end
    return video_source + "?&start=" + start_time.to_s + 
    "&end=" + end_time.to_s
  end

end
