class RenameJobvideosToJobVideos < ActiveRecord::Migration
  def self.up
    rename_table :jobvideos, :job_videos
  end

  def self.down
    rename_table :job_videos, :jobvideos
  end
end
