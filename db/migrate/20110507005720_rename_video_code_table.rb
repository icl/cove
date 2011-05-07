class RenameVideoCodeTable < ActiveRecord::Migration
  def self.up
    rename_table :codes, :tags
  end

  def self.down
    rename_table :tags, :codes
  end
end
