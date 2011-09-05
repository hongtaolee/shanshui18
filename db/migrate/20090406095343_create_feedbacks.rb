class CreateFeedbacks < ActiveRecord::Migration
  def self.up
    create_table :feedbacks do |t|
      t.string :username
      t.string :phone
      t.string :email
      t.text :content
      t.text :html_content
      t.integer :status, :default=>1

      t.timestamps
    end
  end

  def self.down
    drop_table :feedbacks
  end
end
