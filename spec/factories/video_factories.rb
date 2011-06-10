Factory.define :video do |f|
	f.name "Video1"
	f.video_up "test.m4v"
	f.starttime DateTime.now
	f.duration 60.seconds
end
