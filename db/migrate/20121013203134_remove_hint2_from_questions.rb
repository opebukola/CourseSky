class RemoveHint2FromQuestions < ActiveRecord::Migration
  def change
  	remove_column :questions, :second_hint
  	rename_column :questions, :first_hint, :hint
  end
end
