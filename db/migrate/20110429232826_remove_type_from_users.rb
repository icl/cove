class RemoveTypeFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :type
  end

  def self.down
    add_column :users, :type, :string
  end
end
