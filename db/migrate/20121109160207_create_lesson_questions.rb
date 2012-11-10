class CreateLessonQuestions < ActiveRecord::Migration
  def change
    create_table :lesson_questions do |t|
      t.integer :lesson_id
      t.integer :question_id

      t.timestamps
    end
    add_index :lesson_questions, :lesson_id
  	add_index :lesson_questions, :question_id
  end
end
