class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :category
      t.string :title
      t.string :author
      t.integer :status, :default => 1 # 1 正常 -1 删除
      t.text :content
      t.text :html_content

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
