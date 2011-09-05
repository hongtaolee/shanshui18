class AddColumnFeedbacksReply < ActiveRecord::Migration
  def self.up
    add_column :feedbacks, :reply, :text
    add_column :feedbacks, :html_reply, :text
  end

  def self.down
  end
end
