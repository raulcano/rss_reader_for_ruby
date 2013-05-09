class ChangeColumnsTypeToBoolean < ActiveRecord::Migration
  def up
    connection.execute(%q{
      alter table feed_source_entries
      alter column is_read
      type boolean using cast(is_read as boolean)
    })
    connection.execute(%q{
      alter table feed_source_entries
      alter column is_starred
      type boolean using cast(is_starred as boolean)
    })
  end
  def down
    change_column :feed_source_entries, :is_read, :integer
    change_column :feed_source_entries, :is_starred, :integer
  end
end
