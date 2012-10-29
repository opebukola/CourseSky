class AddContentToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :content, :boolean, default: false
  end
end
