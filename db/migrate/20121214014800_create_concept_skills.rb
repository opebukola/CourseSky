class CreateConceptSkills < ActiveRecord::Migration
  def change
    create_table :concept_skills do |t|
      t.integer :concept_id
      t.integer :skill_id

      t.timestamps
    end
    add_index :concept_skills, [:concept_id, :skill_id], unique: true
  end
end
