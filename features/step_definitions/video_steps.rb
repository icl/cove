Given /^(?:|I )want to create a "([^"]*)" video located in "([^"]*)" with duration (\d+) and starttime (\d+) $/ do |name,filepath,duration,starttime|
 unless Video.find(:first, :conditions => { :name => arg1 })
    Video.new(:name => name,
              :filepath => filepath,
              :duration => duration,
              :starttime => starttime).save!
 end
end
