TAG_ACCURACY_THRESHOLD = 1.1

Given /^a turk job$/ do  
  @video = Factory(:video)
  @tag = Factory(:tag)
  @job = Factory(:job, :videos => [@video], :tags => [@tag])
end

Given /^(\d+) turk jobs$/ do |n|
  @video = Factory(:video)
  @tag = Factory(:tag)
  @jobs = Array.new n.to_i do
    Factory(:job, :videos => [@video], :tags => [@tag])
  end
end

When /^(?:|I )click the play button$/ do
  # TODO: better way of waiting for jwplayer to load
  sleep 1
  jwplayer_play
end

When /^I tag the range \[(\d+),(\d+)\] using the hold button$/ do |start_time, end_time|
  sleep(start_time.to_f - jwplayer_position)
  page.execute_script "$('#tagButton_hold_#{@tag.name}').trigger('mousedown')"
  sleep(end_time.to_f - jwplayer_position)
  page.execute_script "$('#tagButton_hold_#{@tag.name}').trigger('mouseup')"  
end

When /^I tag the range \[(\d+),(\d+)\] using the click\-to\-tag button$/ do |start_time, end_time|
  sleep(start_time.to_f - jwplayer_position)
  click_button "tagButton_toggle_#{@tag.name}"
  sleep(end_time.to_f - jwplayer_position)
  click_button "tagButton_toggle_#{@tag.name}"
end

Then /^the tag should be applied the job\/video with approximate range \[(\d+),(\d+)\]$/ do |start_time, end_time|
  # TODO: should instead wait for AJAX call to complete, probably using browser.wait_for_element
  sleep 1
  
  tag = VideoTag.last
  
  tag.tag_id.should == @tag.id
  tag.video_id.should == @video.id
  tag.job_id.should == @job.id
  
  start_time_diff = start_time.to_f - tag.start_time
  end_time_diff = end_time.to_f - tag.end_time
  
  [start_time_diff,end_time_diff].each do |diff|
    diff.abs.to_f.should < TAG_ACCURACY_THRESHOLD
  end
end
