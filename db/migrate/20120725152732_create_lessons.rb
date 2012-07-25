class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :title
      t.string :document
      t.string :video_url
      t.integer :course_id
      t.integer :user_id
      t.integer :document_ipaper_id
      t.string :document_ipaper_access_key
      t.integer :position

      t.timestamps
    end
  end
end
