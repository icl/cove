CODE_ACCURACY_THRESHOLD = 1

Given /^a turk job$/ do
  @job = Factory(:job)
  @video = @job.videos.first
  @code = @job.codes.first
end

When /^(?:|I )click the play button$/ do
  # TODO: better way of waiting for jwplayer to load
  sleep 1
  page.execute_script "jwplayer().play()"
end

When /^(?:|I )wait (\d+) seconds$/ do |n|
  sleep n
end

When /^(?:|I )click the click-to-code button$/ do
  click_button "tagButton_toggle_#{@code.name}"
end

When /^(?:|I )press the hold-to-code button$/ do
  page.execute_script "$('#tagButton_hold_#{@code.name}').trigger('mousedown')"
end

When /^(?:|I )release the hold-to-code button$/ do
  page.execute_script "$('#tagButton_hold_#{@code.name}').trigger('mouseup')"  
end

Then /^a code should be created for the video with approximate range \[(\d+),(\d+)\]$/ do |start_time, end_time|
  code = Videocode.last
  
  start_time_diff = start_time - code.start_time
  end_time_diff = end_time - code.end_time
  
  [start_time_diff,end_time_diff].each do |diff|
    diff.abs.should < CODE_ACCURACY_THRESHOLD
  end
end
