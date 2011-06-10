require 'spec_helper'

describe Taggingvideocount do
  before(:each) do
    @tag = Factory(:tag)
    @vid = Factory :video
  end
  describe ".update_count" do
    it "should create a new entry if it doesn't already exist" do
      Taggingvideocount.update_count(@tag.id, @vid.id)
      Taggingvideocount.where(:tag_id => @tag.id, :video_id => @vid.id).first.should be
    end
    it "should increase the count by 1 for an existing entry" do
      Taggingvideocount.create!(:tag_id => @tag.id, :video_id => @vid.id)
      Taggingvideocount.update_count(@tag.id, @vid.id)
      counter = Taggingvideocount.where(:tag_id => @tag.id, :video_id => @vid.id).first
      counter.applied_count.should == 2    
    end
  end
end
