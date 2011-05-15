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

Given /^(?:|I )want to create a "([^"]*)" training video located in "([^"]*)"$/ do |arg1,arg2|
 unless VideoTraining.find(:first, :conditions => { :name => arg1 })
    VideoTraining.new(:name => arg1,
              :filepath => arg2).save!
 end
end

Then /^A "([^"]*)" training video should exist$/ do |arg1|
   if VideoTraining.find(:first, :conditions => { :name => arg1 }).nil?
      scenario.fail("Training video doesn't exist!")
   end
end

Given /^(?:|I )want to create a "([^"]*)" training module with description "([^"]*)" bound to tag "([^"]*)" and bound to video "([^"]*)"$/ do |arg1,arg2,arg3,arg4|
 unless Training.find(:first, :conditions => { :title => arg1 })
    Training.new(:title => arg1,
                 :description => arg2).save!

    TrainingVideo.new(:training_id => 
         Training.find(:first, :conditions => { :title => arg1 }).id, 
         :video_training_id => 
         VideoTraining.find(:first, :conditions => { :name => arg4 })).save!

    TrainingTag.new(:training_id => 
         Training.find(:first, :conditions => { :title => arg1 }).id,
         :tag_id => Tag.find(:first, :conditions => { :name => arg3 })).save!
 end
end

Then /^A training module should exist with title "([^"]*)" and description "([^"]*)" bound to tag "([^"]*)" and bound to video "([^"]*)"$/ do |arg1,arg2,arg3,arg4|
   VideoTraining.find(:first, :conditions => { :name => arg1 }).nil?
end

Then /^I should select a "([^"]*)" video$/ do |arg1|
   select(arg1, :from => "unbound_video_training_ids[]")
end

Then /^I should select a "([^"]*)" tag$/ do |arg1|
   select(arg1, :from => "unbound_tag_ids[]")
end

Then /^I should enter a "([^"]*)" title$/ do |arg1|
  fill_in("training[title]", :with => arg1)
end

Then /^I should enter a "([^"]*)" description$/ do |arg1|
  fill_in("training[description]", :with => arg1)
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


