Given /^a tag$/ do
  @tag = Factory(:tag)
end

Given /^(?:|I )want to create a "([^"]*)" tag$/ do |arg1|
 unless Tag.find(:first, :conditions => { :name => arg1 })
    Tag.new(:name => arg1).save!
 end
end

Then /^A "([^"]*)" tag should exist$/ do |arg1|
   if Tag.find(:first, :conditions => { :name => arg1 }).nil?
      scenario.fail("Tag couldn't be found!")
   end
end

Then /^"([^"]*)" should be selected from the tags$/ do |tag_name|
	 page.should have_select('Tags', :selected => tag_name)
end
