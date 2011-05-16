class AddDescriptionAndRequestorToJobs < ActiveRecord::Migration
  def self.up
    add_column :jobs, :description, :string
    add_column :jobs, :requestor_id, :integer
  end

  def self.down
    remove_column :jobs, :requestor_id
    remove_column :jobs, :description
  end
end
