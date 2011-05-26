class RenameVideocodesVideoTags < ActiveRecord::Migration
    def self.up
      rename_table :videocodes, :video_tags
    end

    def self.down
      rename_table :video_tags, :videocodes
    end
  end
