Factory.define :user, :class => User do |f|
	f.kind :user
	f.email "user@cove.ucsd.edu"
	f.password "foobar"
end

Factory.define :turk, :class => User do |f|
	f.kind :user
	f.email "emir@cove.ucsd.edu"
	f.password "foobar"
end

Factory.define :gina, :class => User do |f|
	f.kind :admin
	f.email "gina@cove.ucsd.edu"
	f.password "foobar"
end
