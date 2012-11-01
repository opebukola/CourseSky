class CreateLessonItems < ActiveRecord::Migration
  def change
    create_table :lesson_items do |t|
    	#common attributes
    	t.integer :lesson_id
    	t.integer :position
    	t.string :type

    	#video attributes
    	t.string :url
    	t.integer :start_time
    	t.integer :end_time
    	t.text :transcript

    	#question attributes
    	t.string :question_type
    	t.text :question_text
    	t.text :hint
    	
      t.timestamps
    end
  end
end
