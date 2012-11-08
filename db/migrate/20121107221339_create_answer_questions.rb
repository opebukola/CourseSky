class CreateAnswerQuestions < ActiveRecord::Migration
  def change
    create_table :answer_questions do |t|
      t.integer :answer_id
      t.integer :question_id

      t.timestamps
    end
  end
end
