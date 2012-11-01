class Removelessonitems < ActiveRecord::Migration
  def change
  	drop_table :question_attempts
  	drop_table :lesson_positions
  	drop_table :lesson_items
  end
end
