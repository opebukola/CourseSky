class ChangeAnswersToString < ActiveRecord::Migration
  def change
  	change_column :answers, :content, :string
  end
end
