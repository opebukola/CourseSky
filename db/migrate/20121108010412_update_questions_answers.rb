class UpdateQuestionsAnswers < ActiveRecord::Migration
  def change
  	remove_column :questions, :lesson_id
  	rename_column :questions, :hint, :first_hint
  	add_column :questions, :second_hint, :text
  	remove_column :answers, :lesson_item_id
  end
end
