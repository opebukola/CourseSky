class FixAsk < ActiveRecord::Migration
  def change
  	rename_column :answers, :question_id, :lesson_item_id
  end
end
