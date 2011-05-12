class RenameCodeForeignKeys < ActiveRecord::Migration
  def self.up
    rename_column :job_tags, :code_id, :tag_id
    rename_column :video_tags, :code_id, :tag_id
  end

  def self.down
    rename_column :job_tags, :tag_id, :code_id
    rename_column :video_tags, :tag_id, :code_id
  end
end
