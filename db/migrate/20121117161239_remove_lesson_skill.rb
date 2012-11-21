class RemoveLessonSkill < ActiveRecord::Migration
  def change
  	drop_table :lesson_skills
  end
end
