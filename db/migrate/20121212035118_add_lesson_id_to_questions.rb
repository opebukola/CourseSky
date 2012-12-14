class AddLessonIdToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :lesson_id, :integer
    add_column :questions, :mark_as_check, :boolean
  end
end
