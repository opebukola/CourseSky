class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :title
      t.integer :course_id
      t.integer :position

      t.timestamps
    end
  end
end
