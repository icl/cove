Factory.define :video do |f|
	f.name "Video1"
	f.filepath "/videos/test.m4v"
	f.starttime DateTime.now
	f.duration 60.seconds
end
