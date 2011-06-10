Then /^I should select a "([^"]*)" tag for this new job$/ do |arg1|
   select(arg1, :from => "tag_ids[]")
end
Then /^I should select a "([^"]*)" video for this new job$/ do |arg1|
   select(arg1, :from => "video_ids[]")
end

Given /^a video called "([^"]*)"$/ do |name|
  @video = Factory(:video, :name => name)
end
