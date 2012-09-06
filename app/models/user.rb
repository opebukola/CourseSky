class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         authentication_keys: [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :login, :username, :email, :password, 
  								:password_confirmation, :remember_me, :name,
                  :location, :about, :avatar, :admin
  
  #Virtual attribute for authenticating users by either username or email
  attr_accessor :login

  #override default authentication method to use :login
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  has_many :courses
  has_many :lessons
  has_many :enrollments, foreign_key: "student_id", dependent: :destroy
  has_many :enrolled_courses, through: :enrollments
  has_many :course_reviews
  has_many :comments
  has_many :lesson_progressions, foreign_key: "student_id", dependent: :destroy
  has_many :question_attempts, foreign_key: "student_id", dependent: :destroy

  #uplaod avatar
  mount_uploader :avatar, AvatarUploader

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

  #reviews methods
  def has_reviewed?(course)
    return true if
    self.course_reviews.find_by_course_id(course.id)
  end

  #course progress methods

  def completed_lessons(course)
    self.lesson_progressions.completed.find_all_by_enrolled_course_id(course.id).count
  end

  def incomplete_lessons(course)
    course.lessons.count - completed_lessons(course)
  end
  
  def progress(course)
    if self.enrolled?(course)
      complete = completed_lessons(course)
      incomplete = incomplete_lessons(course)
      progress = complete.to_f / (complete.to_f + incomplete.to_f) 
      return progress.round(2) * 100
    end
  end

  def has_completed(lesson)
    self.lesson_progressions.completed.find_by_enrolled_lesson_id(lesson.id)
  end

  #question progress
  def has_answered(question)
    return true if self.question_attempts.find_by_question_id(question.id)
  end

  def reset!(question)
    self.question_attempts.find_by_question_id(question.id).destroy
  end
end
# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(255)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  username               :string(255)
#  avatar                 :string(255)
#  name                   :string(255)
#  location               :string(255)
#  about                  :text
#  admin                  :boolean         default(FALSE)
#

