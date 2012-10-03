class UpdateQuestionModel < ActiveRecord::Migration
  def change
  	rename_column :questions, :hint, :first_hint
  	rename_column :questions, :question_text, :second_hint
  end
end
