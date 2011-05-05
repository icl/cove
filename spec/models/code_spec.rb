require 'spec_helper'

describe Code do
	before(:each) do
		@code = Factory(:code)
	end
	it "should have associated jobs" do
		@code.jobs.length.should == 0
		@code.jobs << Factory(:job)
		@code.jobs.length.should == 1
	end
end
