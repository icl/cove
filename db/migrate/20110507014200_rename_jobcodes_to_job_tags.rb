class RenameJobcodesToJobTags < ActiveRecord::Migration
  def self.up
  rename_table :jobcodes, :job_tags
  end

  def self.down
    rename_table :job_tags, :jobcodes
  end
end
