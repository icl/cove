TAG_ACCURACY_THRESHOLD = 1

Given /^a turk job$/ do  
  @video = Factory(:video)
  @tag = Factory(:tag)
  @job = Factory(:job, :videos => [@video], :tags => [@tag])
end

When /^(?:|I )click the play button$/ do
  # TODO: better way of waiting for jwplayer to load
  sleep 1
  jwplayer_play
end

When /^I tag the range \[(\d+),(\d+)\] using the hold\-to\-tag button$/ do |start_time, end_time|
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

Then /^a code should be created for the video with approximate range \[(\d+),(\d+)\]$/ do |start_time, end_time|
  # TODO: should instead wait for AJAX call to complete, probably using browser.wait_for_element
  sleep 1
  
  tag = VideoTag.last
  
  start_time_diff = start_time.to_f - tag.start_time
  end_time_diff = end_time.to_f - tag.end_time
  
  [start_time_diff,end_time_diff].each do |diff|
    diff.abs.to_f.should < TAG_ACCURACY_THRESHOLD
  end
end
