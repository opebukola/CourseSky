class AddCourseIdToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :course_id, :integer
    add_index :questions, :course_id
  end

end
