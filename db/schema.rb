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

ActiveRecord::Schema.define(:version => 20121030022350) do

  create_table "activities", :force => true do |t|
    t.integer  "lesson_id"
    t.integer  "lesson_position"
    t.integer  "lesson_activity_id"
    t.string   "lesson_activity_type"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "answers", :force => true do |t|
    t.string   "content"
    t.integer  "question_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.boolean  "correct",     :default => false
  end

  add_index "answers", ["question_id"], :name => "index_answers_on_question_id"

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "subject_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "ancestry"
  end

  add_index "categories", ["ancestry"], :name => "index_categories_on_ancestry"
  add_index "categories", ["subject_id"], :name => "index_categories_on_subject_id"

  create_table "categorizations", :force => true do |t|
    t.integer  "category_id"
    t.integer  "course_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "categorizations", ["category_id"], :name => "index_categorizations_on_category_id"
  add_index "categorizations", ["course_id"], :name => "index_categorizations_on_course_id"

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

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

  create_table "completed_questions", :force => true do |t|
    t.integer  "student_id",  :null => false
    t.integer  "question_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "completed_questions", ["student_id"], :name => "index_completed_questions_on_student_id"

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

  create_table "grade_levels", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "lesson_items", :force => true do |t|
    t.integer  "lesson_id"
    t.integer  "lesson_position"
    t.integer  "item_id"
    t.string   "item_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "lesson_positions", :force => true do |t|
    t.integer  "positionable_id"
    t.string   "positionable_type"
    t.integer  "position"
    t.integer  "lesson_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "lessons", :force => true do |t|
    t.string   "title"
    t.text     "document"
    t.string   "video_url"
    t.integer  "course_id"
    t.integer  "user_id"
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "question_attempts", :force => true do |t|
    t.integer  "student_id"
    t.integer  "question_id"
    t.boolean  "completed",   :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "attempts",    :default => 0
    t.integer  "lesson_id"
  end

  add_index "question_attempts", ["lesson_id"], :name => "index_question_attempts_on_lesson_id"
  add_index "question_attempts", ["question_id"], :name => "index_question_attempts_on_question_id"
  add_index "question_attempts", ["student_id"], :name => "index_question_attempts_on_student_id"

  create_table "questions", :force => true do |t|
    t.text     "hint"
    t.integer  "lesson_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "position"
    t.string   "question_type"
    t.text     "explanation"
    t.text     "question_text"
  end

  add_index "questions", ["lesson_id"], :name => "index_questions_on_lesson_id"

  create_table "quizzes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "skill_listings", :force => true do |t|
    t.integer  "skill_id"
    t.integer  "skilled_id"
    t.string   "skilled_type"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "skills", :force => true do |t|
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "subjects", :force => true do |t|
    t.string   "name"
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
    t.string   "name"
    t.string   "location"
    t.text     "about"
    t.boolean  "admin",                  :default => false
    t.boolean  "instructor",             :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "videos", :force => true do |t|
    t.string   "url"
    t.integer  "start_time"
    t.integer  "end_time"
    t.text     "transcript"
    t.integer  "lesson_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "position"
  end

end
