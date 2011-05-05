class CreateJobcodes < ActiveRecord::Migration
  def self.up
    create_table :jobcodes do |t|
      t.integer :job_id
      t.integer :code_id

      t.timestamps
    end
  end

  def self.down
    drop_table :jobcodes
  end
end
