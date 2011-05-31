# ==Schema 
    #t.integer  "tag_id"
    #t.integer  "video_id"
    #t.integer  "applied_count", :default => 0
    #t.datetime "created_at"
    #t.datetime "updated_at"
#
class Taggingvideocount < ActiveRecord::Base
  #create the db entry if one does not already exist for this combination 
  #otherwise update the count of by 1
  def self.update_count(tag_id, video_id)
    counter = Taggingvideocount.where(:tag_id => tag_id, :video_id => video_id).first
    if counter
      Taggingvideocount.increment_counter(:applied_count, counter.id)
    else
      Taggingvideocount.create!(:tag_id => tag_id, :video_id => video_id)
    end
  end
end
