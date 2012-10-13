class AddSnippetToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :snippet, :text
  end
end
