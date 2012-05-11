class CreateFolders < ActiveRecord::Migration
  def change
    create_table :folders do |t|
      t.integer :parent_id
      t.string :title
      t.integer :lft
      t.integer :rgt
      t.integer :depth

      t.timestamps
    end
	
	add_index :folders, :parent_id
	add_index :folders, :lft
	add_index :folders, :rgt
	add_index :folders, :depth
  end
end
