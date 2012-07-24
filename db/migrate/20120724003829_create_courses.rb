class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title
      t.string :cover_image
      t.text :description
      t.boolean :published, default:false
      t.integer :user_id

      t.timestamps
    end
  end
end
