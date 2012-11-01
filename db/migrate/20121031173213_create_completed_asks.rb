class CreateCompletedAsks < ActiveRecord::Migration
  def change
    create_table :completed_asks do |t|
      t.integer :student_id, null: false
      t.integer :lesson_item_id, null: false

      t.timestamps
    end
    add_index :completed_asks, :student_id
  end
end
