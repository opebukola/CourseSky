class AddAnswersToAttempts < ActiveRecord::Migration
  def change
  	add_column :attempts, :response, :string
  	change_column :attempts, :correct, :boolean, default: :false
  end
end
