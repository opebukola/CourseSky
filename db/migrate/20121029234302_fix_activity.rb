class FixActivity < ActiveRecord::Migration
  def change
  	rename_column :activities, :lesson_position, :position
  	rename_column :activities, :activity_id, :lesson_activity_id
  	rename_column :activities, :activity_type, :lesson_activity_type
  end
end
