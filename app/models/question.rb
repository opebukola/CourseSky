# == Schema Information
#
# Table name: questions
#
#  id                :integer          not null, primary key
#  hint              :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  question_type     :string(255)
#  explanation_text  :text
#  question_text     :text
#  difficulty        :integer
#  question_image    :string(255)
#  explanation_video :string(255)
#  lesson_id         :integer
#

class Question < ActiveRecord::Base
  attr_accessible :answers_attributes, :question_type, :difficulty, 
                  :hint, :question_text, :skill_ids, :lesson_id,
                  :question_image, :explanation_video, :explanation_text
  belongs_to :lesson
  has_many :question_skills
  has_many :skills, through: :question_skills
  has_many :answers
  has_many :attempts, dependent: :destroy


  has_one :lesson_activity, as: :activity
  after_save :create_lesson_activity
  before_destroy :delete_lesson_activity
  VIDEO_REGEX = /(https?):\/\/(www.)?(youtube\.com\/watch\?v=|youtu\.be\/|youtube\.com\/watch\?feature=player_embedded&v=)([A-Za-z0-9_-]*)(\&\S+)?(\S)*/



  QUESTION_TYPES = ["Multiple Choice", "Enter Response"]
  QUESTION_DIFFICULTY = [1, 2, 3]



  accepts_nested_attributes_for :answers, allow_destroy: true

  validates :question_type, presence: true
  validates :question_text, presence: true
  validates :hint, presence: true
  validates :answers, presence: true
  validates :difficulty, presence: true
  validate :must_have_skills
  validates :explanation_video, allow_blank:true, format: {with: VIDEO_REGEX}

  mount_uploader :question_image, QuestionImageUploader

  #create embed code for Youtube video URLS
  def video_source
    regex_youtube = VIDEO_REGEX
    if regex_youtube.match(self.explanation_video)
      protocol = $1
      youtube_id = $4
      video_source = "#{protocol}://www.youtube.com/embed/#{youtube_id}?rel=0&hd=1"
    else
      video_source = ""
    end
  end


  def must_have_skills
    errors.add(:question, 'must have at least one skill') if self.skills.empty?
  end

  def is_multiple_choice?
    return true if self.question_type == "Multiple Choice"
  end

  def difficulty_level
    return "Easy" if self.difficulty == 1
    return "Medium" if self.difficulty == 2
    return "Hard" if self.difficulty == 3
  end
 
  #answers 
  def correct_answers
    answer_array = []
    self.answers.find_all_by_correct(:true).each do |answer|
      answer_array<<answer.content.downcase
    end
    return answer_array
  end

  def is_correct?(response)
    self.correct_answers.include?(response.downcase)
  end 

  #lesson activities
  def create_lesson_activity
    id = self.id
    type = 'Question'
    activity = self.lesson.lesson_activities.
    find_or_create_by_activity_id_and_activity_type(id,type)
      activity.save
  end

    def delete_lesson_activity
    LessonActivity.find_by_lesson_id_and_activity_id_and_activity_type(
      self.lesson.id, self.id, 'Question').destroy
  end

  # #quiz methods

  # def last_quiz_attempt(quiz)
  #   quiz.attempts.where(question_id: self.id).order('created_at DESC').first
  # end

  #user attempts  

  def attempted_by?(user)
    Attempt.where(question_id: self.id, user_id: user.id).any?  
  end


  def last_attempt_by(user)
    Attempt.where(
      question_id: self.id, user_id: user.id).order('
      created_at DESC').first
  end

  def correct_attempt?(user)
    return true if 
    self.last_attempt_by(user).correct == true
  end

  def all_attempts_by(user)
    Attempt.where(
      question_id: self.id, user_id: user.id)
  end



  #points
  def possible_points
    20 * self.difficulty
  end

end
