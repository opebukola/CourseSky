class AddAttemptsToQuestionAttempts < ActiveRecord::Migration
  def change
    add_column :question_attempts, :attempts, :integer, default: 0
  end
end
