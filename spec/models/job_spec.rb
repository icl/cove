require 'spec_helper'

describe Job do
	before(:each) do
		@job = Factory(:job)
	end
	it "should have associated tags" do
		@job.tags.length.should == 1
		@job.tags << Factory(:tag)
		@job.tags.length.should == 2
	end
	it "should have associated videos" do
		@job.videos.length.should == 1
		@job.videos << Factory(:video)
		@job.videos.length.should == 2
	end
	it "should return a joblet that has been shown the fewest times to the user"
end
