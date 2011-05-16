Factory.define :training do |f|
   f.title "Test"
   f.description "Descr"
end

Factory.define :video_training do |f|
	f.name "Test Video"
	f.filepath "/videos/trainings/test.mp4"
end

Factory.define(:training_video) do |f|
  f.association :training
  f.association :video_training
end

Factory.define(:training_tag) do |f|
  f.association :training
  f.association :tag
end
