class CreateCourseSkills < ActiveRecord::Migration
  def change
    create_table :course_skills do |t|
      t.integer :course_id
      t.integer :skill_id

      t.timestamps
    end
    add_index :course_skills, [:course_id, :skill_id], unique: true
  end
end
