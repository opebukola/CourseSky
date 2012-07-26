class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :content
      t.text :hint
      t.integer :lesson_id

      t.timestamps
    end
    add_index :questions, :lesson_id
  end
end
