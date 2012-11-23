class AddCourseInfoToQuizzes < ActiveRecord::Migration
  def change
    add_column :quizzes, :course_id, :integer
    add_index :quizzes, [:course_id, :user_id]
  end
end
