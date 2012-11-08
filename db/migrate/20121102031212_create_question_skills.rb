class CreateQuestionSkills < ActiveRecord::Migration
  def change
    create_table :question_skills do |t|
      t.integer :question_id
      t.integer :skill_id

      t.timestamps
    end
    add_index :question_skills, [:question_id, :skill_id], unique: true
  end
end
