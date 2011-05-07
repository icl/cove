CODE_ACCURACY_THRESHOLD = 1

Given /^a turk job$/ do
  @job = Factory(:job)
  @video = @job.videos.first
  @tag = @job.tags.first
end

When /^(?:|I )click the play button$/ do
  # TODO: better way of waiting for jwplayer to load
  sleep 1
  page.execute_script "jwplayer().play()"
end

When /^(?:|I )wait (\d+) seconds$/ do |n|
  sleep n
end

When /^(?:|I )click the click-to-tag button$/ do
  click_button "tagButton_toggle_#{@tag.name}"
end

When /^(?:|I )press the hold-to-tag button$/ do
  page.execute_script "$('#tagButton_hold_#{@tag.name}').trigger('mousedown')"
end

When /^(?:|I )release the hold-to-tag button$/ do
  page.execute_script "$('#tagButton_hold_#{@tag.name}').trigger('mouseup')"  
end

Then /^a code should be created for the video with approximate range \[(\d+),(\d+)\]$/ do |start_time, end_time|
  tag = VideoTag.last
  
  start_time_diff = start_time - code.start_time
  end_time_diff = end_time - code.end_time
  
  [start_time_diff,end_time_diff].each do |diff|
    diff.abs.should < CODE_ACCURACY_THRESHOLD
  end
end
