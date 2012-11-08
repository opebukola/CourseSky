class CreateAnswerAsks < ActiveRecord::Migration
  def change
    create_table :answer_asks do |t|
      t.integer :answer_id
      t.integer :ask_id

      t.timestamps
    end
  end
end
