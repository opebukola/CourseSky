# == Schema Information
#
# Table name: lesson_items
#
#  id            :integer          not null, primary key
#  lesson_id     :integer
#  position      :integer
#  type          :string(255)
#  url           :string(255)
#  start_time    :integer
#  end_time      :integer
#  transcript    :text
#  question_type :string(255)
#  question_text :text
#  hint          :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Video < LessonItem
	attr_accessible :url, :start_time, :end_time, :transcript 

	VIDEO_REGEX = /(https?):\/\/(www.)?(youtube\.com\/watch\?v=|youtu\.be\/|youtube\.com\/watch\?feature=player_embedded&v=)([A-Za-z0-9_-]*)(\&\S+)?(\S)*/

  validates :url, format: {with: VIDEO_REGEX}
  validates :transcript, presence: true

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
