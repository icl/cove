Factory.define :user, :class => User do |f|
	f.admin false
	f.name "User"
end

Factory.define :turk, :class => User do |f|
	f.admin false
	f.name "Emir"
end

Factory.define :gina, :class => User do |f|
	f.admin true
	f.name "Gina"
end
