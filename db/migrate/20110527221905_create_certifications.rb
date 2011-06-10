class CreateCertifications < ActiveRecord::Migration
  def self.up
    create_table :certifications do |t|
      t.references :tag

      t.timestamps
    end
  end

  def self.down
    drop_table :certifications
  end
end
