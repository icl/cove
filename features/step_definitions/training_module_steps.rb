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
      raise "Training video doesn't exist!"
   end
end

Given /^(?:|I )want to create a "([^"]*)" training module with description "([^"]*)" bound to tag "([^"]*)" and bound to video "([^"]*)"$/ do |arg1,arg2,arg3,arg4|
 unless Training.find(:first, :conditions => { :title => arg1 })
    Training.new(:title => arg1,
                 :description => arg2).save!

    TrainingVideo.new(:training_id => 
         Training.find(:first, :conditions => { :title => arg1 }).id, 
         :video_training_id => 
         VideoTraining.find(:first, :conditions => { :name => arg4 }).id).save!

    TrainingTag.new(:training_id => 
         Training.find(:first, :conditions => { :title => arg1 }).id,
         :tag_id => Tag.find(:first, :conditions => { :name => arg3 }).id).save!
 end
end

Then /^A training module should exist with title "([^"]*)" and description "([^"]*)" bound to tag "([^"]*)" and bound to video "([^"]*)"$/ do |arg1,arg2,arg3,arg4|
   training = Training.find(:first, :conditions => { :title => arg1 })
   if training.nil?
      raise "Training module doesn't exist!"
   else
      unless training.title.eql?(arg1)
         raise "Training module titles don't match!"
      end

      unless training.description.eql?(arg2)
         raise "Training module descriptions don't match!"
      end

      tag = Tag.find(:first, :conditions => { :name => arg3 })
      if tag.nil?
         raise "Tag doesn't exist!"
      else 
         training_tag = TrainingTag.find(:first, :conditions => {:tag_id => tag.id, :training_id => training.id} )
         if training_tag.nil?
            raise "Training tag relationship doesn't exist!"
         end
      end

      video_training = VideoTraining.find(:first, :conditions => { :name => arg4})
      if video_training.nil?
         raise "Training video doesn't exist?"
      else
         training_video = TrainingVideo.find(:first, :conditions => {:video_training_id  => video_training.id, :training_id => training.id} )
         if training_video.nil?
            raise "Training video relationship doesn't exist!"
         end
      end
   end
end

Then /^A training module should not exist with title "([^"]*)" and description "([^"]*)" bound to tag "([^"]*)" and bound to video "([^"]*)"$/ do |arg1,arg2,arg3,arg4|
   unless Training.find(:first, :conditions => { :title => arg1 }).nil?
      raise "Training module exists!"
   else
      # We should have no mappings left either
      if TrainingVideo.count > 0
         raise "Training Video mappings exist!"
      end

      if TrainingTag.count > 0
         raise "Training Tag mappings exist!"
      end
   end
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
