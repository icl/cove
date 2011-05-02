Factory.define :job do |f|
	f.budget 100
	f.spent 0
	f.active true
end

Factory.define :jobvideo do |f|
	f.video_id do
		Video.first ? Video.first : Factory(:video)
	end
	f.job_id do
		Job.first ? Job.first : Factory(:job)
	end
end

Factory.define :jobcode do |f|
	f.code_id do
		Code.first ? Code.first : Factory(:code)
	end
	f.job_id do
		Job.first ? Job.first : Factory(:job)
	end
end
