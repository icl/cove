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
      Indexer.should_receive(:update_index).with do |params|
        params[:type] == "tag"
        params[:term] == name
        params[:db_id] == id
      end
      @tagging.index_tag
    end

    it "should post to the cove_search server" do
      name = @tagging.tag.name
      id = @tagging.id
      Indexer.should_receive(:post).with do |path, parameters|
        path == "/update_index"
        parameters == {:type => "tag:test", :term => @tagging.tag.name.downcase, :db_id => @tagging.id}
      end.and_return({"status" => "successful" })
      @tagging.index_tag
    end
  end

  describe ".search" do
    it "should query the cove_search server" do
      Indexer.should_receive(:search).with do |params|
        params[:type] == "tag:test"
        params[:query] == "hello"
      end
      VideoTag.search "hello"
    end

    it "should make a get request to the cove_search server" do
      Indexer.should_receive(:get).with do |path, parameters|
        path == "/update_index"
        parameters == {:type => "tag:test", :query => "hello"}
      end.and_return({"results" => []})
      VideoTag.search "hello"
    end

    it "should return an AR result array" do
      VideoTag.search(@tagging.tag.name).should == [@tagging]
    end

    it "should allow for query chaining" do
      VideoTag.search(@tagging.tag.name).where(:user_id => @tagging.user_id).should == [@tagging]
    end

    it "should return an empty array if the search servers returns nothing" do
      Indexer.should_receive(:search).and_return([])
      VideoTag.search("hello").should == []
    end

  end
end
