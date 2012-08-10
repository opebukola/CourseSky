class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :lesson_id
      t.text :content
      t.string :ancestry

      t.timestamps
    end
    add_index :comments, :ancestry
    add_index :comments, :user_id
    add_index :comments, :lesson_id
  end
end
