class CreateQuestionAttempts < ActiveRecord::Migration
  def change
    create_table :question_attempts do |t|
      t.integer :student_id
      t.integer :question_id
      t.boolean :completed, default: false

      t.timestamps
    end
    add_index :question_attempts, :student_id
    add_index :question_attempts, :question_id
  end
end
