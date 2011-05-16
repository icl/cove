Factory.define :training do |f|
   f.title "Test"
   f.description "Descr"
	f.training_videos { [Factory(:training_video)] }
	f.training_tags { [Factory(:training_tag)] }
end

Factory.define :training_video do |f|
	f.video_training_id do
		TrainingVideo.first ? TrainingVideo.first : Factory(:video_training)
	end
	f.training_id do
		Training.first ? Training.first : Factory(:training)
	end
end

Factory.define :training_tag do |f|
	f.training_tag_id do
		TrainingTag.first ? TrainingTag.first : Factory(:tag)
	end
	f.training_id do
		Training.first ? Training.first : Factory(:training)
	end
end
