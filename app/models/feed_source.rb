class FeedSource < ActiveRecord::Base
  attr_accessible :folder_id, :hashtags, :title, :url, :user_id
  has_many :feed_entries, dependent: :destroy
  validates :title, presence: true, length: { maximum: 50}
  validates :user_id, presence: true
  
  validates :url, presence: true, 
					format: { with: URI::ABS_URI },
                    uniqueness: { case_sensitive: false }
  
  default_scope order: 'feed_sources.created_at DESC'
end
