class RemoveObjectiveFromQuestions < ActiveRecord::Migration
  def change
  	remove_column :questions, :prompt
  end
end
