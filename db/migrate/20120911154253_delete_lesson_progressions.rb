class DeleteLessonProgressions < ActiveRecord::Migration
  def change
  	drop_table :lesson_progressions
  end
end
