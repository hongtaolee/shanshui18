class AddColumnIndexContentsContentA < ActiveRecord::Migration
  def self.up
    add_column :index_contents, :content_a, :text
    add_column :index_contents, :content_b, :text
  end

  def self.down
  end
end
