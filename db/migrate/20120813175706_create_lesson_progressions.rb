class CreateLessonProgressions < ActiveRecord::Migration
  def change
    create_table :lesson_progressions do |t|
      t.integer :student_id
      t.integer :enrolled_course_id
      t.integer :enrolled_lesson_id
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
