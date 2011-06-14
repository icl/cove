# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

video = Factory(:video)
tag = Factory(:tag)
turk = Factory(:turk)
gina = Factory(:gina)
job = Factory(:job, :videos => [video], :tags => [tag])
tag.certification.certification_videos.create(:video => video, :seeder => gina)
[[1,2],[3,4],[5,6],[7,8]].each do |st, et|
  VideoTag.create(:video => video, :tag => tag, :user => gina, :start_time => st, :end_time => et)
end
