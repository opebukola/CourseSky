class AddIndexToEnrollments < ActiveRecord::Migration
  def change
  	add_index :enrollments, [:student_id, :enrolled_course_id], unique: true
  end
end
