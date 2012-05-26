class CreateFeedSourceEntries < ActiveRecord::Migration
  def change
    create_table :feed_source_entries do |t|
      t.integer :feed_source_id
      t.integer :feed_entry_id
      t.integer :is_starred, :default => 0
      t.integer :is_read, :default => 0

      t.timestamps
    end
   
    add_index :feed_source_entries, :feed_source_id
    add_index :feed_source_entries, :feed_entry_id
    add_index :feed_source_entries, [:feed_source_id, :feed_entry_id], unique: true
  end
end
