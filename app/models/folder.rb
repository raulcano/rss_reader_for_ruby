class Folder < ActiveRecord::Base
  acts_as_nested_set
  include TheSortableTree::Scopes
  
  attr_accessible :depth, :lft, :parent_id, :rgt, :title
  
  validates :title, presence: true, length: { maximum: 50 }
end
