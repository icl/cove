class CreateCertificationVideos < ActiveRecord::Migration
  def self.up
    create_table :certification_videos do |t|
      t.references :certification
      t.references :video

      t.timestamps
    end
  end

  def self.down
    drop_table :certification_videos
  end
end
