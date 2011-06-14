CERTIFICATION_TEST_TAGS = [[1, 2], [3, 4], [5, 6]]
CERTIFICATION_TEST_WRONG_TAGS = [[1, 2]]

Given /^a seeded certification video for the tag$/ do
  Given "an unseeded certification video for the tag"
  @tag.should_not be_nil
  @video.should_not be_nil
  # Find Gina
  gina = User.find_by_name("Gina") || Factory(:gina)
  # Add tags to certification video
  CERTIFICATION_TEST_TAGS.each do |st, et|
    vt = VideoTag.create(:tag => @tag, :user => gina, :video => @video, :start_time => st, :end_time => et)
    vt.save.should == true
  end
  # Set seeder to Gina
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
  CERTIFICATION_TEST_TAGS.each do |st, et|
    When "I tag the range [#{st},#{et}] using the hold-to-tag button"
  end
end

When /^I apply the wrong tags to a video$/ do
  When "I click the play button"
  CERTIFICATION_TEST_WRONG_TAGS.each do |st, et|
    When "I tag the range [#{st},#{et}] using the hold-to-tag button"
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

Then /^I should be certified for the tag$/ do
  User.find_by_name("Emir").certified_for_tag?(@tag).should be_true
end

Then /^I should not be certified for the tag$/ do
  User.find_by_name("Emir").certified_for_tag?(@tag).should be_false
end