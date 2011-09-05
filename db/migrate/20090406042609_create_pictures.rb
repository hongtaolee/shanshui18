class CreatePictures < ActiveRecord::Migration
  def self.up
    create_table :pictures do |t|
      t.string :name
      t.string :file_path
      t.string :category
      t.integer :hits, :default => 0
      t.integer :status, :default => 1 

      t.timestamps
    end
  end

  def self.down
    drop_table :pictures
  end
end
