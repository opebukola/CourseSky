class RemoveVideoFromLessons < ActiveRecord::Migration
  def change
  	remove_column :lessons, :video_url
  	remove_column :questions, :position
  	remove_column :questions, :second_hint
  	rename_column :questions, :first_hint, :hint
  end
end
