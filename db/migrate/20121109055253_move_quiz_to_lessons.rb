class MoveQuizToLessons < ActiveRecord::Migration
  def change
  	rename_column :quizzes, :course_id, :lesson_id
  end
end
