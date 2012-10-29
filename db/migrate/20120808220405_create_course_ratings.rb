class CreateCourseRatings < ActiveRecord::Migration
  def change
    create_table :course_ratings do |t|
      t.integer :course_id
      t.integer :user_id
      t.text :content
      t.integer :value

      t.timestamps
    end
  end
end
