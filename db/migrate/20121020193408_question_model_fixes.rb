class QuestionModelFixes < ActiveRecord::Migration
  def change
  	remove_column :questions, :course_id
  	remove_column :questions, :video_start
  	remove_column :questions, :video_end
  	remove_column :questions, :transcript
  end
end
