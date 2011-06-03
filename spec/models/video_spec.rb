require 'spec_helper'

describe Video do

  before(:each) do
		@video = Factory(:video)
	end
	it "should have associated jobs" do
		@video.jobs.length.should == 0
		@video.jobs << Factory(:job)
		@video.jobs.length.should == 1
	end

  describe "#method_missing" do
    it "should throw an exception if the method is not a unique query" do
      lambda { Video.blah }.should raise_error
    end

    it "should not raise method missing if method name is unique_*" do
      lambda { Video.unique_name }.should_not raise_error
    end

    it "should return a list of unique attributes" do
      Video.unique_names.should == ["Video1"]
    end
  end

end
