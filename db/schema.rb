# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090914065757) do

  create_table "comments", :force => true do |t|
    t.integer  "post_id"
    t.integer  "reply_id"
    t.text     "content"
    t.text     "html_content"
    t.string   "username"
    t.integer  "status",       :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["post_id"], :name => "index_comments_on_post_id"

  create_table "feedbacks", :force => true do |t|
    t.string   "username"
    t.string   "phone"
    t.string   "email"
    t.text     "content"
    t.text     "html_content"
    t.integer  "status",       :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "reply"
    t.text     "html_reply"
  end

  create_table "index_contents", :force => true do |t|
    t.integer  "category",   :null => false
    t.string   "pic1"
    t.string   "pic2"
    t.string   "pic3"
    t.string   "title"
    t.string   "s1"
    t.string   "s2"
    t.string   "s3"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "content_a"
    t.text     "content_b"
  end

  create_table "pictures", :force => true do |t|
    t.string   "name"
    t.string   "file_path"
    t.string   "category"
    t.integer  "hits",       :default => 0
    t.integer  "status",     :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.string   "category"
    t.string   "title"
    t.string   "author"
    t.integer  "status",         :default => 1
    t.text     "content"
    t.text     "html_content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hits",           :default => 0
    t.date     "publish_date"
    t.boolean  "is_top",         :default => false
    t.boolean  "is_new",         :default => false
    t.integer  "comments_count", :default => 0
    t.string   "quote_url"
  end

end
