require 'spec_helper'

describe FeedSource do

  let(:user) { FactoryGirl.create(:user) }
  let(:feed_source) { FactoryGirl.create(:feed_source, user: user, created_at: 1.hour.ago) }
  let(:feed_source_similar_URL) { FactoryGirl.create(:feed_source, user: user, created_at: 1.hour.ago) }
  let(:feed_source_different_URL) { FactoryGirl.create(:feed_source, url: "http://elmundo.feedsportal.com/elmundo/rss/portada.xml" ) }
  
  subject {feed_source}
  
  it { should respond_to(:feed_source_entries) }  
  # to make this one pass, we have to add to the feed_source.rb the following
  # has_many :feed_entries, through: :feed_source_entries, source: "feed_entry_id"
  it { should respond_to(:feed_entries) } 


  it { should respond_to(:has_entry?) }
  it { should respond_to(:add_entry!) }
  it { should respond_to(:remove_entry!) }
  it { should respond_to(:update_entries!) }
 

  describe "adding entry" do
    let(:other_feed_entry) { FactoryGirl.create(:feed_entry) }    
    before do
      feed_source.save
      feed_source.add_entry!(other_feed_entry)
    end

    it { should be_has_entry(other_feed_entry) }
    its(:feed_entries) { should include(other_feed_entry) }
    

    describe "and removing entry" do
      before {  feed_source.remove_entry!(other_feed_entry) }

      it { should_not be_has_entry(other_feed_entry) }
      its(:feed_entries) { should_not include(other_feed_entry) }
    end


  end
  
  describe "updating entries" do
    # we also create 
    # => another feed_source with the same source URL 
    # => another feed_source with different source URL
    
    # Note, the URL in the test feed_source must be a valid one so the update_entries
    # extracts the real feed entries and we can check that they have really been assigned
    # to both sources with similar URLs 
      
    before do
      feed_source.save
      feed_source_similar_URL.save
      feed_source_different_URL.save
    end
  
  # We have to check that when one feed_source is updated
    # the feed_sources that share the same URL are updated also
    # by adding the corresponding entries in the feed_source_entries table
    # So, for every feed_entry recently added to feed_source, we check that
    # it is added also to feed_source_similar_URL  
    # Also, we have to check that an unrelated feed_source is left unmodified
    it "should update same entries for feed_sources with same URL and not update the ones with different URL" do
      new_entries = feed_source.update_entries!
      new_entries.each do |entry|
        feed_entry = FeedEntry.find_by_guid(entry.entry_id)
        feed_source.should have_entry(feed_entry)
        feed_source_similar_URL.should have_entry(feed_entry)
        feed_source_different_URL.should_not have_entry(feed_entry)
      end
    end
  end

  describe "deleting feed sources" do
    # We check that the destroy action does not destroy the feed entries if other user 
    # has the same feed_source
    before do
      feed_source.save
      feed_source_similar_URL.save
      feed_source_different_URL.save
    end
 
    it "should delete source, entries and the relationships when the source is unique (no other source has the same url)" do
      feed_source_different_URL.update_entries!
      feed_entries = feed_source_different_URL.feed_entries
      feed_source_id = feed_source_different_URL.id 
      feed_source_different_URL.destroy
      feed_entries.each do |entry|
        FeedEntry.find_by_id(entry.id).should be_nil
      end
      FeedSourceEntry.find_by_feed_source_id(feed_source_id).should be_nil
      FeedSource.find_by_id(feed_source_id).should be_nil
    end
    
    it "should delete source and the relationships when the source is not unique (other source has the same url)" do
      feed_source.update_entries!
      feed_entries = feed_source.feed_entries
      feed_source_id = feed_source.id
      feed_source.destroy
      # This is to check that the other source still has the associated feed_entries
      feed_entries.each do |entry|
        feed_source_similar_URL.should have_entry(entry)
      end
      FeedSourceEntry.find_by_feed_source_id(feed_source_id).should be_nil
      FeedSource.find_by_id(feed_source_id).should be_nil
    end
  end

  
end