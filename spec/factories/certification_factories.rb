Factory.define :certification, :class => Certification do |f|
	f.tag { Factoryr(:tag)}
	f.videos { [Factory(:video)] }
end

Factory.define :seeded_certification_video, :class => CertificationVideo do |f|

end

Factory.define :unseeded_certification_video, :class => CertificationVideo do |f|
end
