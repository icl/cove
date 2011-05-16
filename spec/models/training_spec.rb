require 'spec_helper'

describe Training do
   before(:each) do
      @training = Factory(:training)
   end

   after(:each) do
      @training = nil
   end

   it "should require a title" do
    no_title_training = Training.new(@training.merge(:title => ""))
    no_title_training.should_not be_valid
   end

   it "should require a file path" do
    no_description_training = Training.new(@training.merge(:description => ""))
    no_description_training.should_not be_valid
   end

  it "should reject names that are too long" do
    long_title = "a" * 51
    long_title_training = Training.new(@training.merge(:title => long_title))
    long_title_training.should_not be_valid
  end

  it "should reject file paths that are too long" do
    long_description = "a" * 256
    long_description_training = Training.new(@training.merge(:description => long_description))
    long_description_training.should_not be_valid
  end



end
