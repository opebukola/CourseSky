class CreateSkillListings < ActiveRecord::Migration
  def change
    create_table :skill_listings do |t|
      t.integer :skill_id
      t.integer :skilled_id
      t.string :skilled_type

      t.timestamps
    end
  end
end
