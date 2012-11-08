class CreateAttempts < ActiveRecord::Migration
  def change
    create_table :attempts do |t|
      t.datetime :started_at
      t.datetime :ended_at
      t.boolean :correct
      t.integer :question_id
      t.integer :user_id

      t.timestamps
    end
  end
end
