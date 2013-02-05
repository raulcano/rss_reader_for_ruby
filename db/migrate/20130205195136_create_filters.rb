class CreateFilters < ActiveRecord::Migration
 def change
   create_table :filters do |t|
     t.string :title
     t.string :description
     t.string :url
     t.integer :user_id

     t.timestamps
   end
 end
end