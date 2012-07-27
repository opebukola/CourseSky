class AddSubjectToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :subject_id, :integer
    add_index :courses, :subject_id
  end
 
end
