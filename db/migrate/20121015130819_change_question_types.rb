class ChangeQuestionTypes < ActiveRecord::Migration
  def change
  	change_column :questions, :prompt, :string
  	remove_column :questions, :content
  	remove_column :questions, :video_start
  	remove_column :questions, :video_end
  	remove_column :questions, :snippet
  end
end
