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
      t.boolean :submitter, :default => false
      t.boolean :admin, :default => false

      t.index :oauth_uid, :unique => true
      t.index :oauth_token, :unique => false
      t.index :email, :unique => true
    end

    create_table :submissions do |t|
      t.belongs_to :account

      t.string :title, :null => false
      t.boolean :current, :default => true
      t.boolean :draft, :default => false
      t.text :text, :null => false
      t.timestamps
    end

    create_table :votes do |t|
      t.belongs_to :submission
      t.belongs_to :account

      t.boolean :approved, :default => false
      t.timestamps

      t.index :approved
      t.index :submission_id
      t.index :account_id
    end

    create_table :comments do |t|
      t.belongs_to :submission
      t.belongs_to :comment
      t.belongs_to :account

      t.text :text, :null => false

      t.index :comment_id, :unique => false
      t.index :submission_id, :unique => false
      t.index :account_id, :unique => false
    end
  end

  def down
    tables = [:accounts, :submissions, :votes, :comments]
    tables.each do |t|
      drop_table t
    end
  end
end
