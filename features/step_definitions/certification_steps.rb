Given /^a seeded certification video for the tag$/ do
  @certification = @tag.certification
  @certification_video = Factory(:seeded_certification_video, :certification => @certification)
end

Given /^an unseeded certification video for the tag$/ do
  @certification = @tag.certification
  @certification_video = Factory(:unseeded_certification_video, :certification => @certification)
end