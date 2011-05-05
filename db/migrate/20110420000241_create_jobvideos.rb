class CreateJobvideos < ActiveRecord::Migration
  def self.up
    create_table :jobvideos do |t|
      t.integer :job_id
      t.integer :video_id

      t.timestamps
    end
  end

  def self.down
    drop_table :jobvideos
  end
end
