require 'spec_helper'

describe Training do
   before(:all) do
      @training = Factory(:training)
   end

   before(:each) do
   	@attr = { :title => "Test Title", :description => "Test Description" }
   end

   it "should require a title" do
    no_title_training = Training.new(@attr.merge(:title => ""))
    no_title_training.should_not be_valid
   end

   it "should require a file path" do
    no_description_training = Training.new(@attr.merge(:description => ""))
    no_description_training.should_not be_valid
   end

  it "should reject names that are too long" do
    long_title = "a" * 51
    long_title_training = Training.new(@attr.merge(:title => long_title))
    long_title_training.should_not be_valid
  end

  it "should reject file paths that are too long" do
    long_description = "a" * 256
    long_description_training = Training.new(@attr.merge(:description => long_description))
    long_description_training.should_not be_valid
  end

	it "should have associated videos" do
		@training.video_trainings.count.should == 0
      @training.video_trainings << Factory(:video_training)
		@training.video_trainings.count.should == 1
	end

	it "should have associated tags" do
		@training.tags.count.should == 0
      @training.tags << Factory(:tag)
		@training.tags.count.should == 1
	end


end
