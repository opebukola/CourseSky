class ChangeTitleToObjective < ActiveRecord::Migration
  def change
  	rename_column :questions, :title, :objective
  end
end
