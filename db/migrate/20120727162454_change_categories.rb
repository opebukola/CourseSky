class ChangeCategories < ActiveRecord::Migration
  def change
  	rename_column :categories, :maincategory_id, :subject_id
  	add_index :categories, :subject_id
  end
end
