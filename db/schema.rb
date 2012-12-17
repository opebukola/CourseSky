# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121217230832) do

  create_table "answers", :force => true do |t|
    t.string   "content"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.boolean  "correct",     :default => false
    t.integer  "question_id"
  end

  create_table "attempts", :force => true do |t|
    t.datetime "started_at"
    t.datetime "ended_at"
    t.boolean  "correct",     :default => false
    t.integer  "question_id"
    t.integer  "user_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "response"
    t.integer  "quiz_id"
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "lesson_id"
    t.text     "content"
    t.string   "ancestry"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["ancestry"], :name => "index_comments_on_ancestry"
  add_index "comments", ["lesson_id"], :name => "index_comments_on_lesson_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "concept_skills", :force => true do |t|
    t.integer  "concept_id"
    t.integer  "skill_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "concept_skills", ["concept_id", "skill_id"], :name => "index_concept_skills_on_concept_id_and_skill_id", :unique => true

  create_table "concepts", :force => true do |t|
    t.integer  "lesson_id"
    t.string   "video_url"
    t.integer  "video_start"
    t.integer  "video_end"
    t.text     "doc"
    t.string   "title"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "course_reviews", :force => true do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.text     "content"
    t.integer  "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "courses", :force => true do |t|
    t.string   "title"
    t.string   "cover_image"
    t.text     "description"
    t.boolean  "published",      :default => false
    t.integer  "user_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.boolean  "featured",       :default => false
    t.integer  "subject_id"
    t.integer  "grade_level_id"
  end

  add_index "courses", ["grade_level_id"], :name => "index_courses_on_grade_level_id"
  add_index "courses", ["subject_id"], :name => "index_courses_on_subject_id"

  create_table "enrollments", :force => true do |t|
    t.integer  "student_id"
    t.integer  "enrolled_course_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "enrollments", ["enrolled_course_id"], :name => "index_enrollments_on_enrolled_course_id"
  add_index "enrollments", ["student_id", "enrolled_course_id"], :name => "index_enrollments_on_student_id_and_enrolled_course_id", :unique => true
  add_index "enrollments", ["student_id"], :name => "index_enrollments_on_student_id"

  create_table "lesson_activities", :force => true do |t|
    t.integer  "position"
    t.integer  "lesson_id"
    t.string   "activity_type"
    t.integer  "activity_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "lesson_questions", :force => true do |t|
    t.integer  "lesson_id"
    t.integer  "question_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "lesson_questions", ["lesson_id"], :name => "index_lesson_questions_on_lesson_id"
  add_index "lesson_questions", ["question_id"], :name => "index_lesson_questions_on_question_id"

  create_table "lessons", :force => true do |t|
    t.string   "title"
    t.text     "document"
    t.integer  "unit_id"
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "question_skills", :force => true do |t|
    t.integer  "question_id"
    t.integer  "skill_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "question_skills", ["question_id", "skill_id"], :name => "index_question_skills_on_question_id_and_skill_id", :unique => true

  create_table "questions", :force => true do |t|
    t.text     "hint"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "question_type"
    t.text     "explanation_text"
    t.text     "question_text"
    t.integer  "difficulty"
    t.string   "question_image"
    t.string   "explanation_video"
    t.integer  "lesson_id"
  end

  create_table "quizzes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "lesson_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "course_id"
  end

  add_index "quizzes", ["course_id", "user_id"], :name => "index_quizzes_on_course_id_and_user_id"

  create_table "skills", :force => true do |t|
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "ancestry"
  end

  add_index "skills", ["ancestry"], :name => "index_skills_on_ancestry"

  create_table "units", :force => true do |t|
    t.string   "title"
    t.integer  "course_id"
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "avatar"
    t.string   "location"
    t.text     "about"
    t.boolean  "admin",                  :default => false
    t.boolean  "instructor",             :default => false
    t.string   "fname"
    t.string   "lname"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
