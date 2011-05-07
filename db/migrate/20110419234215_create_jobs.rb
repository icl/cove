class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.float :budget
      t.float :spent
      t.boolean :active

      t.timestamps
    end
  end

  def self.down
    drop_table :jobs
  end
end
