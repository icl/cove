class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.string :name #Title of the video ( "Session 1 Winter Practice" )
      t.string :filepath #Location of file on server ("gunpowder/public/videos/whatever/file.mp4")
      t.float :duration #Length of the video ("13344 seconds")
      t.datetime :starttime #Actual time video was recorded in Epoch ("14:13:12 31/12/2011")
      t.text :comments #Any comments about the video that are extra ("Lavolier mic failed")

      t.timestamps
    end
  end

  def self.down
    drop_table :videos
  end
end
