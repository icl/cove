class AddSeederToCertificationVideos < ActiveRecord::Migration
  def self.up
    add_column :certification_videos, :seeder_id, :integer
  end

  def self.down
    remove_column :certification_videos, :seeder_id
  end
end
