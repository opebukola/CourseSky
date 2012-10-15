class FixQuestionParams < ActiveRecord::Migration
  def change
  	remove_column :questions, :video_url
  	add_column :questions, :video_start, :integer
    add_column :questions, :video_end, :integer
  end
end
