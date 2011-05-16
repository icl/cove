class CreateVideoTrainings < ActiveRecord::Migration
  def self.up
    create_table :video_trainings do |t|
      t.string :name
      t.string :filepath

      t.timestamps
    end
  end

  def self.down
    drop_table :video_trainings
  end
end
