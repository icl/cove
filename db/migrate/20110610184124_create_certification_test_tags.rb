class CreateCertificationTestTags < ActiveRecord::Migration
  def self.up
    create_table :certification_test_tags do |t|
      t.references :certification_test
      t.references :tag
      t.decimal :start_time
      t.decimal :end_time

      t.timestamps
    end
  end

  def self.down
    drop_table :certification_test_tags
  end
end
