class AddIntroToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :intro, :text
  end
end
