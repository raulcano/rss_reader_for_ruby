class CreateFeedSourceEntries < ActiveRecord::Migration
  def change
    create_table :feed_source_entries do |t|
      t.integer :feed_source_id
      t.integer :feed_entry_id
      t.boolean :is_starred, :default => false
      t.boolean :is_read, :default => false

      t.timestamps
    end
   
    add_index :feed_source_entries, :feed_source_id
    add_index :feed_source_entries, :feed_entry_id
    # I set the name on this incex because otherwise, there would be 
    # problems when migrating due to the automatically genarated
    # name length
    add_index :feed_source_entries, [:feed_source_id, :feed_entry_id], 
            {unique: true, name: "feed_source_entries_unique"}  
  end
end
