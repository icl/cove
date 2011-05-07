require 'spec_helper'

describe Videocode do
	before(:each) do
		@coding = Factory(:coding)
	end
	it "should have a video" do
		@coding.video.class.should == Video
	end
	it "should have a code" do
		@coding.code.class.should == Code
	end
	it "should have a job" do
		@coding.job.class.should == Job
	end
	it "should have a user" do
		@coding.user.class.should == User
	end
	it "should return the proper length" do
		@coding.start_time = 5.seconds
		@coding.end_time = 10.seconds
		@coding.length.should == 5.seconds
	end
	it "should set the length properly" do
		@coding.start_time = 10.seconds
		@coding.length = 10.seconds
		@coding.end_time.should == 20.seconds
	end
end
