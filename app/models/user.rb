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

