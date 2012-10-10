class ChangeDocType < ActiveRecord::Migration
 def change
 		change_column :lessons, :document, :text
 		remove_column :lessons, :document_ipaper_id
 		remove_column :lessons, :document_ipaper_access_key
 end
end
