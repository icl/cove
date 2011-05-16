class CreateDefaultValueForUserKind < ActiveRecord::Migration
  def self.up
    remove_column :users, :kind
    add_column :users, :kind, :string, :default => "turk"
  end

  def self.down
    remove_column :users, :kind
    add_column :users, :kind, :string
  end
end
