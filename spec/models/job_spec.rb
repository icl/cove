require 'spec_helper'

describe Job do
	before(:each) do
		@job = Factory(:job)
	end
	it "should have associated codes" do
		@job.codes.length.should == 1
		@job.codes << Factory(:code)
		@job.codes.length.should == 2
	end
	it "should have associated videos" do
		@job.videos.length.should == 1
		@job.videos << Factory(:video)
		@job.videos.length.should == 2
	end
end
