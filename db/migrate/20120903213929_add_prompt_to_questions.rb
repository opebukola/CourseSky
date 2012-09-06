class AddPromptToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :prompt, :text
  end
end
