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
end
