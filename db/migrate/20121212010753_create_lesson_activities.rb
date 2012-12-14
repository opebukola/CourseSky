class CreateLessonActivities < ActiveRecord::Migration
  def change
    create_table :lesson_activities do |t|
      t.integer :position
      t.integer :lesson_id
      t.string :activity_type
      t.integer :activity_id

      t.timestamps
    end
  end
end
