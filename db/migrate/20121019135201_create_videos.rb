class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :url
      t.integer :start_time
      t.integer :end_time
      t.text :transcript
      t.integer :lesson_id

      t.timestamps
    end
  end
end
