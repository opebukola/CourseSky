class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.integer :student_id
      t.integer :enrolled_course_id

      t.timestamps
    end
    add_index :enrollments, :student_id
    add_index :enrollments, :enrolled_course_id
  end
end
