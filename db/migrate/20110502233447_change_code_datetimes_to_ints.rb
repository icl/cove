class ChangeCodeDatetimesToInts < ActiveRecord::Migration
  def self.up
    remove_column :videocodes, :start_time, :datetime
    remove_column :videocodes, :end_time, :datetime
    add_column :videocodes, :start_time, :decimal
    add_column :videocodes, :end_time, :decimal
  end

  def self.down
    remove_column :videocodes, :start_time, :decimal
    remove_column :videocodes, :end_time, :decimal
    add_column :videocodes, :start_time, :datetime
    add_column :videocodes, :end_time, :datetime
  end
end
