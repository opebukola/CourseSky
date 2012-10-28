class CreateCompletedQuestions < ActiveRecord::Migration
  def change
    create_table :completed_questions do |t|
    	t.integer :student_id, null: false
    	t.integer :question_id, null: false
      t.timestamps
    end
    add_index :completed_questions, :student_id
  end
end
