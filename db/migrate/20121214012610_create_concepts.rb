class CreateConcepts < ActiveRecord::Migration
  def change
    create_table :concepts do |t|
      t.integer :lesson_id
      t.string :video_url
      t.integer :video_start
      t.integer :video_end
      t.text :doc
      t.string :title

      t.timestamps
    end
  end
end
