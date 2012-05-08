class AddTheSortedTreeColumnsToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :parent_id, :integer
    add_column :microposts, :lft, :integer
    add_column :microposts, :rgt, :integer
    add_column :microposts, :depth, :integer
  end
end
