class LessonPosition < ActiveRecord::Migration
  def change
  	rename_column :activities, :position, :lesson_position
  end
end
