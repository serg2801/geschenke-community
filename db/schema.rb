# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20160519091734) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "average_caches", :force => true do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "avg",           :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "criteria"
    t.text     "description"
  end

  add_index "categories", ["slug"], :name => "index_categories_on_slug"

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["product_id"], :name => "index_comments_on_product_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "coocie_modules", :force => true do |t|
    t.string   "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "herodata", :force => true do |t|
    t.string "name"
    t.text   "value"
  end

  create_table "ip_addresses", :force => true do |t|
    t.string   "ip"
    t.boolean  "mobile",     :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "legacy_links", :force => true do |t|
    t.string "name"
    t.string "slug"
    t.string "new_url"
  end

  add_index "legacy_links", ["slug"], :name => "index_legacy_links_on_slug"

  create_table "lists", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "permalink"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "lists", ["permalink"], :name => "index_lists_on_permalink"
  add_index "lists", ["user_id"], :name => "index_lists_on_user_id"

  create_table "lists_products", :id => false, :force => true do |t|
    t.integer "list_id"
    t.integer "product_id"
  end

  add_index "lists_products", ["list_id", "product_id"], :name => "index_lists_products_on_list_id_and_product_id"
  add_index "lists_products", ["product_id", "list_id"], :name => "index_lists_products_on_product_id_and_list_id"

  create_table "overall_averages", :force => true do |t|
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "overall_avg",   :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "url"
    t.decimal  "price",       :precision => 8, :scale => 2
    t.string   "slug"
    t.integer  "user_id"
    t.integer  "clicks",                                    :default => 0
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
    t.string   "image"
    t.text     "root_url"
    t.text     "criteria"
    t.float    "fb_likes",                                  :default => 0.0
  end

  add_index "products", ["clicks"], :name => "index_products_on_clicks"
  add_index "products", ["price"], :name => "index_products_on_price"
  add_index "products", ["slug"], :name => "index_products_on_slug"
  add_index "products", ["user_id"], :name => "index_products_on_user_id"

  create_table "rates", :force => true do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "stars",         :null => false
    t.string   "dimension"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "rates", ["rateable_id", "rateable_type"], :name => "index_rates_on_rateable_id_and_rateable_type"
  add_index "rates", ["rater_id"], :name => "index_rates_on_rater_id"

  create_table "rating_caches", :force => true do |t|
    t.integer  "cacheable_id"
    t.string   "cacheable_type"
    t.float    "avg",            :null => false
    t.integer  "qty",            :null => false
    t.string   "dimension"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "rating_caches", ["cacheable_id", "cacheable_type"], :name => "index_rating_caches_on_cacheable_id_and_cacheable_type"

  create_table "rating_products", :force => true do |t|
    t.integer  "product_id"
    t.integer  "ip_address_id"
    t.integer  "evaluation",    :default => 0
    t.boolean  "liked",         :default => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "image"
    t.integer  "points",                 :default => 0
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.boolean  "hero",                   :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["points"], :name => "index_users_on_points"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
