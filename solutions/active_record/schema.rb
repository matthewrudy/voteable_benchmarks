ActiveRecord::Schema.define(:version => 1) do
  create_table "users", :force => true do |t|
    t.string   "name"
    t.boolean  "happy"
  end

  add_index "users", ["id"], :name => "index_users_on_id"
    

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "up_votes_count", :default => 0
    t.integer  "down_votes_count", :default => 0
    t.integer  "votes_count", :default => 0
    t.integer  "votes_point", :default => 0
  end

  add_index "posts", ["id"], :name => "index_posts_on_id"

  unless SKIP_ADDITIONAL_INDEXES
    add_index "posts", ["up_votes_count"], :name => "index_posts_on_up_votes_count"
    add_index "posts", ["down_votes_count"], :name => "index_posts_on_down_votes_count"
    add_index "posts", ["votes_count"], :name => "index_posts_on_votes_count"
    add_index "posts", ["votes_point"], :name => "index_posts_on_votes_point"
  end


  create_table "votes", :force => true do |t|
    t.integer "post_id"
    t.integer "user_id"
    t.boolean "value" # true => :up, false => :down
  end
  add_index "votes", ["post_id", "user_id"], :name => "index_votes_on_post_id_and_user_id", :unique => true
  # add_index "votes", ["user_id", "post_id"], :name => "index_votes_on_user_id_and_post_id", :unique => true
end
