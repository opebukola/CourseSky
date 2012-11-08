class RemoveDeletedModels < ActiveRecord::Migration
 def change
 	drop_table :ckeditor_assets
 	drop_table :completed_questions
 	drop_table :activities
 	drop_table :subjects
 	drop_table :skill_listings
 end
end
