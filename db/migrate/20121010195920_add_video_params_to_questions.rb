class AddVideoParamsToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :video_start, :integer
    add_column :questions, :video_end, :integer
  end
end
