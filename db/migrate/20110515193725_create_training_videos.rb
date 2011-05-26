class CreateTrainingVideos < ActiveRecord::Migration
  def self.up
    create_table :training_videos do |t|
      t.integer :training_id
      t.integer :video_training_id

      t.timestamps
    end
  end

  def self.down
    drop_table :training_videos
  end
end
