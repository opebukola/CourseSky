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
#  name                   :string(255)
#  location               :string(255)
#  about                  :text
#  admin                  :boolean          default(FALSE)
#  instructor             :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name,
                  :location, :about, :avatar

  has_many :courses
  has_many :lessons
  has_many :enrollments, foreign_key: "student_id", dependent: :destroy
  has_many :enrolled_courses, through: :enrollments
  has_many :comments
  # has_many :completed_questions, foreign_key: "student_id", dependent: :destroy
  has_many :completed_asks, foreign_key: "student_id", dependent: :destroy
  has_many :quizzes
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

  #question aka "ask" status

  def has_answered?(ask)
    return true if 
    self.completed_asks.find_by_lesson_item_id(ask.id)
  end

  #lesson progress
  def completed_lesson?(lesson)
    asks = LessonItem.find_all_by_lesson_id_and_type(lesson.id, 'Ask') 
    asks.all? {|ask| self.has_answered?(ask)}
  end

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
    lessons = Lesson.find_all_by_course_id(course.id)
    lessons.all? {|lesson| self.completed_lesson?(lesson)}
  end

  def completed_lessons(course)
    lessons = Lesson.find_all_by_course_id(course.id)
    lessons.select {|lesson| self.completed_lesson?(lesson)}
  end

  def incomplete_lessons(course)
    course.lessons.count - completed_lessons(course).size
  end

  def progress(course)
    if self.enrolled?(course)
      total = course.lessons.size
      complete = completed_lessons(course).size
      incomplete = incomplete_lessons(course)
      progress = complete.to_f / total.to_f
      return progress.round(2) * 100
    end
  end


end
