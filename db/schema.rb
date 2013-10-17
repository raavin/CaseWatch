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

ActiveRecord::Schema.define(:version => 20131017031801) do

  create_table "case_notes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "consumer_id"
    t.integer  "service_id"
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "case_notes", ["consumer_id"], :name => "index_case_notes_on_consumer_id"
  add_index "case_notes", ["service_id"], :name => "index_case_notes_on_service_id"
  add_index "case_notes", ["user_id"], :name => "index_case_notes_on_user_id"

  create_table "categories", :force => true do |t|
    t.integer  "service_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "categories", ["service_id"], :name => "index_categories_on_service_id"

  create_table "consumers", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.date     "birthdate"
    t.integer  "country_id"
    t.boolean  "gender"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "consumers", ["country_id"], :name => "index_consumers_on_country_id"

  create_table "expenditures", :force => true do |t|
    t.integer  "consumer_id"
    t.integer  "user_id"
    t.integer  "service_id"
    t.string   "description"
    t.float    "amount"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "expenditures", ["consumer_id"], :name => "index_expenditures_on_consumer_id"
  add_index "expenditures", ["service_id"], :name => "index_expenditures_on_service_id"
  add_index "expenditures", ["user_id"], :name => "index_expenditures_on_user_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "services", :force => true do |t|
    t.string   "service_name"
    t.text     "description"
    t.integer  "min_age"
    t.integer  "max_age"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "waiting_lists", :force => true do |t|
    t.integer  "consumer_id"
    t.integer  "service_id"
    t.integer  "category_id"
    t.datetime "referral_date"
    t.datetime "acceptance_date"
    t.datetime "completed_date"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "waiting_lists", ["category_id"], :name => "index_waiting_lists_on_category_id"
  add_index "waiting_lists", ["consumer_id"], :name => "index_waiting_lists_on_consumer_id"
  add_index "waiting_lists", ["service_id"], :name => "index_waiting_lists_on_service_id"

end
