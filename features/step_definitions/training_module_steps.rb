Given /^(?:|I )am an admin user who is logged in$/ do
 unless User.find(:first, :conditions => { :email => "test@test.com" })
 User.new(:email => "test@test.com",
   :password => "testtest",
   :password_confirmation => "testtest",
   :kind => "admin").save!
 end

   visit("/users/sign_in")
   fill_in("user_email", :with => "test@test.com")
   fill_in("user_password", :with => "testtest")
   click_button("user_submit")
end

Then /^I should select a video$/ do
   select("1", :from => "unbound_video_ids[]")
end

Then /^I should select a tag$/ do
   select("1", :from => "unbound_tag_ids[]")
end

Then /^I should enter a name$/ do
  fill_in("module_name", :with => "Test Training Module")
end

Then /^I should enter a description$/ do
  fill_in("module_description", :with => "Test Training Module Description")
end

Then /^I press the "([^"]*)" button$/ do |arg1|
  click_button(arg1)
end

When /^I select a "([^"]*)" from the "([^"]*)" dropdown$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

When /^I select "([^"]*)" (\d+)$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end


