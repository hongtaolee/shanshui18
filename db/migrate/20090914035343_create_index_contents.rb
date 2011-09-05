class CreateIndexContents < ActiveRecord::Migration
  def self.up
    create_table :index_contents do |t|
      t.integer :category, :null => false
      t.string :pic1, :pic2,:pic3
      t.string :title
      t.string :s1, :s2, :s3
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :index_contents
  end
end
