require 'spec_helper'

describe VideoTag do
	before(:each) do
		@tagging = Factory(:tagging)
	end
	it "should have a video" do
		@tagging.video.class.should == Video
	end
	it "should have a tag" do
		@tagging.tag.class.should == Tag
	end
	it "should have a job" do
		@tagging.job.class.should == Job
	end
	it "should have a user" do
		@tagging.user.class.should == User
	end
	it "should return the proper length" do
		@tagging.start_time = 5.seconds
		@tagging.end_time = 10.seconds
		@tagging.length.should == 5.seconds
	end
	it "should set the length properly" do
		@tagging.start_time = 10.seconds
		@tagging.length = 10.seconds
		@tagging.end_time.should == 20.seconds
	end

  describe "index_tag" do
    it "should call the indexer with the parameters from the model" do
      Indexer.expects(:update_index).with do |params|
        params[:type] == "tag"
        params[:term] == @tagging.tag.name
        params[:db_id] == @tagging.id
      end
      @tagging.index_tag
    end
  end
end
