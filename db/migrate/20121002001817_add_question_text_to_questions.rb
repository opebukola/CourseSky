class AddQuestionTextToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :question_text, :text
  end
end
