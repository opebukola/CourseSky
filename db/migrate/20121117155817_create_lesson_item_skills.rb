class CreateLessonItemSkills < ActiveRecord::Migration
  def change
    create_table :lesson_item_skills do |t|
      t.integer :lesson_item_id
      t.integer :skill_id

      t.timestamps
    end
    add_index :lesson_item_skills, [:lesson_item_id, :skill_id], unique: true
  end
end
