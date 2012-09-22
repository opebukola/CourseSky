class ReaddPromptToQuestions < ActiveRecord::Migration
  def change
  	remove_column :questions, :objective
  	add_column :questions, :prompt, :text
  end
end
