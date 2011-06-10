Factory.define :tag, :class => Tag do |f|
	f.name "Riffing"
	f.description "Description goes here"
end

Factory.define :tagging, :class => VideoTag do |f|
	f.start_time 0.seconds
	f.end_time 30.seconds
	f.video_id do
		Video.first ? Video.first : Factory(:video)
	end
	f.tag_id do
		Tag.first ? Tag.first : Factory(:tag)
	end
	f.job_id do
		Job.first ? Job.first : Factory(:job)
	end
	f.user_id do
		User.first ? User.first : Factory(:user)
	end
end
