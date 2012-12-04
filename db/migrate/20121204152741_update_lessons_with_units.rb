class UpdateLessonsWithUnits < ActiveRecord::Migration
  def change
  	rename_column :lessons, :course_id, :unit_id
  	remove_column :lessons, :user_id
  end
end
