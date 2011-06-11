class AddVideoUpToVideos < ActiveRecord::Migration
  def self.up
    add_column :videos, :video_up, :string
  end

  def self.down
    remove_column :videos, :video_up
  end
end
