class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :post_id
      t.integer :reply_id
      t.text :content
      t.text :html_content
      t.string :username
      t.integer :status, :default => 1

      t.timestamps
    end
    add_index :comments, [:post_id]
  end

  def self.down
    drop_table :comments
  end
end
