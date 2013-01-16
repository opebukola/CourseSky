class UpdateAttemptQuiz < ActiveRecord::Migration
  def change
  	remove_column :attempts, :quiz_id
  end
end
