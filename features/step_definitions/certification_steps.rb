CERTIFICATION_TEST_TAGS = [[1, 2], [3, 4], [5, 6]]

Given /^a seeded certification video for the tag$/ do
  Given "an unseeded certification video for the tag"
  @tag.should_not be_nil
  @video.should_not be_nil
  # Add tags to certification video
  CERTIFICATION_TEST_TAGS.each do |times|
    vt = VideoTag.create(:tag => @tag, :user => gina, :video => @video, :start_time => times[0], :end_time => times[1])
    vt.save.should == true
  end
  # Set seeder to Gina
  gina = User.find_by_name("Gina")
  gina = Factory(:gina) if gina.nil?
  @certification_video.seeder = gina;
  @certification_video.save.should == true
end

Given /^an unseeded certification video for the tag$/ do
  @tag.should_not be_nil
  @certification = @tag.certification
  @video = Factory(:video)
  @certification_video = CertificationVideo.create(:certification => @certification, :video => @video)
  @certification_video.save.should == true
end

When /^I apply the correct tags to a video$/ do
  When "I click the play button"
  CERTIFICATION_TEST_TAGS.each do |times|
    When "I tag the range [#{times[0]},#{times[1]}] using the hold-to-tag button"
  end
end

Then /^the certification video should be seeded$/ do
  @certification_video.reload
  @certification_video.seeded?.should be_true
end

Then /^the certification video should be seeded with the correct intervals$/ do
  Then "the certification video should be seeded"
  @certification_video.reload
  cvtags = @certification_video.tags
  cvtags.should_not be_nil
  cvtags.length.should == CERTIFICATION_TEST_TAGS.length
  CERTIFICATION_TEST_TAGS.each_index do |i|
    start_time_diff = CERTIFICATION_TEST_TAGS[i][0] - cvtags[i].start_time
    end_time_diff = CERTIFICATION_TEST_TAGS[i][1] - cvtags[i].end_time
    
    [start_time_diff,end_time_diff].each do |diff|
      diff.abs.to_f.should < TAG_ACCURACY_THRESHOLD
    end
  end
end