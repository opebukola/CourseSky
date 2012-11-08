class CreateLessonSkills < ActiveRecord::Migration
  def change
    create_table :lesson_skills do |t|
      t.integer :lesson_id
      t.integer :skill_id

      t.timestamps
    end
    add_index :lesson_skills, [:lesson_id, :skill_id], unique: true
  end
end



