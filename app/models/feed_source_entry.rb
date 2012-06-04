class FeedSourceEntry < ActiveRecord::Base
  attr_accessible :feed_entry_id, :is_read, :is_starred

  belongs_to :feed_source
  belongs_to :feed_entry

  validates :feed_source_id, presence: true
  validates :feed_entry_id, presence: true
  validates_uniqueness_of :feed_source_id, scope: :feed_entry_id
  
  # This is sorting the feed_source_entries by the published_at attribute from
  # a join with :feed_entries table
  
  # The following creates an read-only error as per
  # http://stackoverflow.com/questions/639171/what-is-causing-this-activerecordreadonlyrecord-error
  # default_scope joins(:feed_entry).order('feed_entries.published_at DESC, created_at DESC')
  
  # This one avoids the read_only error
  default_scope joins: :feed_entry, select: 'feed_source_entries.*,feed_entries.published_at',
         order: 'feed_entries.published_at DESC, feed_source_entries.created_at DESC'
  
  def is_read?
       self.is_read
  end

  def mark_read!
        self.update_attribute(:is_read, true)
  end

  def mark_unread!
        self.update_attribute(:is_read, false)
  end 
  
  def is_starred?
       self.is_starred
  end

  def star!
        self.update_attribute(:is_starred, true)
  end

  def unstar!
        self.update_attribute(:is_starred, false)
  end
end

