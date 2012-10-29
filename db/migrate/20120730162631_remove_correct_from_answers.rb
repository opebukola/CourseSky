class RemoveCorrectFromAnswers < ActiveRecord::Migration
  def change
  	remove_column :answers, :correct_answer
  end
end
