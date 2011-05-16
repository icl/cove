require 'spec_helper'

describe VideoTraining do
   before(:each) do
      @video_training = Factory(:video_training)
      @attr = { :name => "Test Video", :filepath => "test.mp4" }
   end

   it "should require a name" do
    no_name_training_video = VideoTraining.new(@attr.merge(:name => ""))
    no_name_training_video.should_not be_valid
   end

   it "should require a file path" do
    no_filepath_training_video = VideoTraining.new(@attr.merge(:filepath => ""))
    no_filepath_training_video.should_not be_valid
   end

  it "should reject names that are too long" do
    long_name = "a" * 51
    long_name_training_video = VideoTraining.new(@attr.merge(:name => long_name))
    long_name_training_video.should_not be_valid
  end

  it "should reject file paths that are too long" do
    long_filepath = "a" * 256
    long_filepath_training_video = VideoTraining.new(@attr.merge(:filepath => long_filepath))
    long_filepath_training_video.should_not be_valid
  end
end
