# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  avatar                 :string(255)
#  location               :string(255)
#  about                  :text
#  admin                  :boolean          default(FALSE)
#  instructor             :boolean          default(FALSE)
#  fname                  :string(255)
#  lname                  :string(255)
#  provider               :string(255)
#  uid                    :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, 
                  :location, :about, :avatar, :fname, :lname

  has_many :courses
  has_many :lessons
  has_many :enrollments, foreign_key: "student_id", dependent: :destroy
  has_many :enrolled_courses, through: :enrollments
  has_many :comments
  has_many :quizzes
  has_many :attempts, dependent: :destroy
  has_many :attempted_questions, through: :attempts, source: :question
  
  mount_uploader :avatar, AvatarUploader

  #facebook oauth

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.fname = auth.extra.raw_info.first_name
      user.lname = auth.extra.raw_info.last_name
    end
  end

  def self.new_with_session(params,session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  #allow oauth users to sign in without password
  def password_required?
    super && provider.blank?
  end

  #allow oauth users to update profile without password

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end


  #enrollment methods
  def enroll!(course)
    self.enrollments.create!(enrolled_course_id:course.id)
  end

  def withdraw!(course)
    self.enrollments.find_by_enrolled_course_id(course.id).destroy
  end

  def enrolled?(course)
    return true if
    self.enrollments.find_by_enrolled_course_id(course.id)
  end



  # def last_attempt_by(user)
  #   Attempt.where(
  #     question_id: self.id, user_id: user.id).order('
  #     created_at DESC').first
  # end


  # #question aka "ask" status

  # def has_answered?(ask)
  #   return true if 
  #   self.completed_asks.find_by_lesson_item_id(ask.id)
  # end

  # #lesson progress
  # def completed_lesson?(lesson)
  #   asks = LessonItem.find_all_by_lesson_id_and_type(lesson.id, 'Ask') 
  #   asks.all? {|ask| self.has_answered?(ask)}
  # end


  # def lesson_progress(lesson)
  #   total_asks = lesson.asks_count
  #   complete = completed_lessons(course).size
  #   progress = complete.to_f / total_asks.to_f
  #   return progress.round(2) * 100
  #   end
  # end

  # def lesson_progress(lesson)
  #   if self.completed_lesson?(lesson)
  #     return 'completed'
  #   elsif self.completed_questions.find_all_by_lesson_id(lesson.id).any?
  #     return 'in progress'
  #   else
  #     return 'not started'
  #   end
  # end

  #course progress
  def completed_course?(course)
    lessons = course.lessons
    lessons.all? {|lesson| self.completed_lesson?(lesson)}
  end

  # def completed_lessons(course)
  #   lessons = course.lessons
  #   lessons.select {|lesson| self.completed_lesson?(lesson)}
  # end

  def incomplete_lessons(course)
    course.lessons.count - completed_lessons(course).size
  end

  def progress(course)
    if self.enrolled?(course)
      total = course.lessons.size
      complete = completed_lessons(course).size
      incomplete = incomplete_lessons(course)
      progress = complete.to_f / total.to_f
      return progress * 100
    end
  end

  def quiz_count(course)
    self.quizzes.find_all_by_course_id(course.id).size
  end

  def quiz_question_count(course)
    quizzes = self.quizzes.find_all_by_course_id(course)
    questions = quizzes.map{ 
      |quiz| quiz.final_attempts.size}
    questions.reduce(:+)
  end


end
