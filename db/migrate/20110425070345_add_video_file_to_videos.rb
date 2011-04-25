class AddVideoFileToVideos < ActiveRecord::Migration
  def self.up
    add_column :videos, :filepath, :string
  end

  def self.down
    remove_column :videos, :filepath
  end
end
