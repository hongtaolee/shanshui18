class ProcessPostsOnline < ActiveRecord::Migration
  def self.up
    Post.update_all("category=3")
  end

  def self.down
  end
end
