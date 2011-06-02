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
      name = @tagging.tag.name
      id = @tagging.id
      Indexer.expects(:update_index).twice.with do |params|
        params[:type] == "tag"
        params[:term] == name
        params[:db_id] == id
      end
      @tagging.index_tag
    end

    it "should post to the cove_search server" do
      name = @tagging.tag.name
      id = @tagging.id
      Indexer.expects(:post).with do |path, parameters|
        path == "/update_index"
        parameters == {:type => "tag", :term => @tagging.tag.name, :db_id => @tagging.id}
      end.returns({"status" => "successful" })
    end
    
  end
end
