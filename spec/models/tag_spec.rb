require 'spec_helper'

describe Tag do
	before(:each) do
		@tag = Factory(:tag)
	end
	it "should have associated jobs" do
		@tag.jobs.length.should == 0
		@tag.jobs << Factory(:job)
		@tag.jobs.length.should == 1
	end
end
