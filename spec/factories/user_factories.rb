Factory.define :user, :class => User do |f|
	f.kind :user
	f.name "John Smith"
	f.email "user@cove.ucsd.edu"
	f.password "foobar"
end

Factory.define :turk, :class => User do |f|
	f.kind :user
	f.name "Emir"
	f.email "emir@cove.ucsd.edu"
	f.password "foobar"
end

Factory.define :gina, :class => User do |f|
	f.kind :admin
	f.name "Gina"
	f.email "gina@cove.ucsd.edu"
	f.password "foobar"
end
