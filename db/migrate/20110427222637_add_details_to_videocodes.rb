class AddDetailsToVideocodes < ActiveRecord::Migration
  def self.up
    add_column :videocodes, :start_time, :datetime
    add_column :videocodes, :end_time, :datetime
    add_column :videocodes, :job_id, :integer
    add_column :videocodes, :user_id, :integer
  end

  def self.down
    remove_column :videocodes, :user_id
    remove_column :videocodes, :job_id
    remove_column :videocodes, :end_time
    remove_column :videocodes, :start_time
  end
end
