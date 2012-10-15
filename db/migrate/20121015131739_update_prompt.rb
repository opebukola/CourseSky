class UpdatePrompt < ActiveRecord::Migration
  def change
  	rename_column :questions, :prompt, :video_url
  end
end
