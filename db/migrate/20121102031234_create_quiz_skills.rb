class CreateQuizSkills < ActiveRecord::Migration
  def change
    create_table :quiz_skills do |t|
      t.integer :quiz_id
      t.integer :skill_id

      t.timestamps
    end
    add_index :quiz_skills, [:quiz_id, :skill_id], unique: true
  end
end
