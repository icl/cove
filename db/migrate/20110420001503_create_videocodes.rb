class CreateVideocodes < ActiveRecord::Migration
  def self.up
    create_table :videocodes do |t|
      t.integer :video_id
      t.integer :code_id

      t.timestamps
    end
  end

  def self.down
    drop_table :videocodes
  end
end
