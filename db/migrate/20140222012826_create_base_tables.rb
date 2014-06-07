class CreateBaseTables < ActiveRecord::Migration
  def up
    create_table :accounts do |t|
      t.string :oauth_token, :null => false
      t.string :oauth_uid, :null => false
      t.string :name, :null => false
      t.string :email, :null => false
      t.text :bio, :null => true
      t.timestamps

      t.boolean :reviewer, :default => false
      t.boolean :email_verified, :default => false
      t.boolean :submitter, :default => false
      t.boolean :admin, :default => false

      t.index :oauth_uid, :unique => true
      t.index :oauth_token, :unique => false
      t.index :email, :unique => true
    end
  end

  def down
    tables = [:accounts]
    tables.each do |t|
      drop_table t
    end
  end
end
