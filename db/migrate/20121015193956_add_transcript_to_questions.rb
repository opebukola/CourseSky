class AddTranscriptToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :transcript, :text
  end
end
