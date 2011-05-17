class CreateWorkRecords < ActiveRecord::Migration
  def self.up
    create_table :work_records do |t|
      t.references :job
      t.references :user
      t.references :video

      t.timestamps
    end
  end

  def self.down
    drop_table :work_records
  end
end
