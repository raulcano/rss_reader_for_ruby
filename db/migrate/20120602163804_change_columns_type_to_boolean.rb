class ChangeColumnsTypeToBoolean < ActiveRecord::Migration
  def change
    change_column :feed_source_entries, :is_read, :boolean
    change_column :feed_source_entries, :is_starred, :boolean
  end
end
