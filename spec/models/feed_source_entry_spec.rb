require 'spec_helper'

describe Feed_source_entry do
  
  let(:user) { FactoryGirl.create(:user) }
  let(:feed_source) { FactoryGirl.create(:feed_source, user: @user, created_at: 1.hour.ago) }
  let(:feed_entry) { FactoryGirl.create(:feed_entry) }
  let(:feed_source_entry) { feed_source.feed_source_entries.build(feed_entry: feed_entry.id) }

  subject { feed_source_entry }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to feed_source_id" do
      expect do
        Feed_source_entry.new(feed_source_id: feed_source.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

  describe "methods" do    
    it { should respond_to(:feed_source) }
    it { should respond_to(:feed_entry) }
    its(:feed_source) { should == feed_source }
    its(:feed_entry) { should == feed_entry }
  end

  describe "when feed_source id is not present" do
    before { feed_source_entry.feed_source_id = nil }
    it { should_not be_valid }
  end

  describe "when feed_entry id is not present" do
    before { feed_source_entry.feed_entry_id = nil }
    it { should_not be_valid }
  end


end