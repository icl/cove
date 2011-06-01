Factory.define :certification, :class => Certification do |f|
	f.tag { Tag.first }
	f.videos { [Video.first] }
end

Factory.define :seeded_certification_video, :class => CertificationVideo do |f|

end

Factory.define :unseeded_certification_video, :class => CertificationVideo do |f|
end
