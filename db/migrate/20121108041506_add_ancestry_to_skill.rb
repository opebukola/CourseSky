class AddAncestryToSkill < ActiveRecord::Migration
  def change
    add_column :skills, :ancestry, :string
    add_index :skills, :ancestry
  end
end
