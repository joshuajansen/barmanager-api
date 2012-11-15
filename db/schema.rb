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

ActiveRecord::Schema.define(:version => 20121115144453) do

  create_table "bank_transactions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "bar_id"
    t.string   "description"
    t.float    "amount"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "bar_enlargements", :force => true do |t|
    t.integer  "bar_id"
    t.integer  "enlargement_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "bar_expansions", :force => true do |t|
    t.integer  "bar_id"
    t.integer  "expansion_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "bar_features", :force => true do |t|
    t.integer  "bar_id"
    t.integer  "feature_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "bars", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.string   "country"
    t.integer  "city_id"
    t.integer  "capacity",   :default => 100
  end

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.integer  "population"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "country"
  end

  create_table "enlargements", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.float    "investment"
    t.integer  "capacity"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "icon"
  end

  create_table "expansions", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.float    "investment"
    t.float    "revenue"
    t.integer  "profit"
    t.integer  "popularity"
    t.integer  "max_use"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.float    "consumption", :default => 0.1
    t.string   "icon"
  end

  create_table "features", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.float    "investment"
    t.integer  "popularity"
    t.integer  "duration"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "icon"
  end

  create_table "sells", :force => true do |t|
    t.integer  "bar_expansion_id"
    t.integer  "amount"
    t.float    "revenue"
    t.float    "profit"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.date     "date"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",     :null => false
    t.string   "encrypted_password",     :default => "",     :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "authentication_token"
    t.float    "balance",                :default => 1000.0
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
