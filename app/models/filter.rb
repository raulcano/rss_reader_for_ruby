class Filter < ActiveRecord::Base
 attr_accessible :title, :description, :url
 
 belongs_to :user
 
 validates :title, presence: true, length: { maximum: 50}
 validates :description, presence: true, length: { maximum: 100}
 validates :user_id, presence: true
 validates :url, presence: true,
          format: 
          { 
            with: URI::ABS_URI, 
            message: 'may be a valid URL'
          }
 validates :url, 
          format: 
          { 
            with: /\[url\]/,
            message: 'may contain the string [url] (this will be substituted by the RSS URL when you associate a filter to any feed source)'
          }
 default_scope order: 'filters.created_at DESC'
 
end