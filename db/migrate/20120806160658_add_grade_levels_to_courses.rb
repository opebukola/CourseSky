class AddGradeLevelsToCourses < ActiveRecord::Migration
  def change
  	add_column :courses, :grade_level_id, :integer
  	add_index :courses, :grade_level_id
  end
end
