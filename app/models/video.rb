# == Schema Information
#
# Table name: videos
#
#  id         :integer          not null, primary key
#  url        :string(255)
#  start_time :integer
#  end_time   :integer
#  transcript :text
#  lesson_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  position   :integer
#

class Video < ActiveRecord::Base
  attr_accessible :end_time, :start_time, :transcript, :url, :lesson_id
  belongs_to :lesson
  # has_one :activity, as: :lesson_activity
  # has_one :lesson_position, through: :activity, source: :lesson_activity, source_type: 'Video'
  acts_as_list scope: :lesson
  
  
  VIDEO_REGEX = /(https?):\/\/(www.)?(youtube\.com\/watch\?v=|youtu\.be\/|youtube\.com\/watch\?feature=player_embedded&v=)([A-Za-z0-9_-]*)(\&\S+)?(\S)*/

  validates :url, format: {with: VIDEO_REGEX}
  validates :lesson_id, presence:true
  validates :transcript, presence:true

  #create embed code for Youtube video URLS
  def video_source
    regex_youtube = VIDEO_REGEX
    if regex_youtube.match(self.url)
      protocol = $1
      youtube_id = $4
      video_source = "#{protocol}://www.youtube.com/embed/#{youtube_id}"
    else
      video_source = ""
    end
  end

  def video_clip_source
    video_source = self.video_source
    start_time = self.start_time
    end_time = self.end_time
    return video_source + "?&start=" + start_time.to_s + 
    "&end=" + end_time.to_s
  end
end
