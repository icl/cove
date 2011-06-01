class CreateUserCertifications < ActiveRecord::Migration
  def self.up
    create_table :user_certifications do |t|
      t.references :user
      t.references :certification

      t.timestamps
    end
  end

  def self.down
    drop_table :user_certifications
  end
end
