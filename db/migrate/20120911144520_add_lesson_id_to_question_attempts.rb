class AddLessonIdToQuestionAttempts < ActiveRecord::Migration
  def change
    add_column :question_attempts, :lesson_id, :integer
    add_index :question_attempts, :lesson_id
  end
end
