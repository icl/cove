Factory.define :code, :class => Code do |f|
	f.name "Riffing"
end

Factory.define :coding, :class => VideoCode do |f|
	f.start_time 0.seconds
	f.end_time 30.seconds
	f.video_id do
		Video.first ? Video.first : Factory :video
	end
	f.code_id do
		Code.first ? Code.first : Factory :code
	end
	f.job_id do
		Job.first ? Job.first : Factory :job
	end
	f.user_id do
		User.first ? User.first : Factory :user
	end
end
