class CreateCategorizations < ActiveRecord::Migration
  def change
    create_table :categorizations do |t|
      t.integer :category_id
      t.integer :course_id

      t.timestamps
    end
    add_index :categorizations, :category_id
    add_index :categorizations, :course_id
  end
end
