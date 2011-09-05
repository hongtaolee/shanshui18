class AddColumnPostsPublishDate < ActiveRecord::Migration
  def self.up
    add_column :posts, :publish_date, :date
    add_column :posts, :is_top, :boolean, :default => false
    add_column :posts, :is_new, :boolean, :default => false
    add_column :posts, :comments_count, :integer, :default => 0
    execute("update posts set publish_date = date(created_at)")
  end

  def self.down
  end
end
