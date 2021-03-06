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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151024164355) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "batches", force: true do |t|
    t.integer  "elaboration_day"
    t.integer  "lifespan"
    t.integer  "daily_batch"
    t.integer  "intern_use_1"
    t.integer  "intern_use_2"
    t.integer  "verify_digit"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "elaboration_month"
    t.integer  "elaboration_year"
    t.integer  "product_type_id"
  end

  add_index "batches", ["product_type_id"], name: "index_batches_on_product_type_id", using: :btree

  create_table "packing_types", force: true do |t|
    t.integer  "amount"
    t.string   "measure"
    t.integer  "code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "gross_weight"
  end

  create_table "product_types", force: true do |t|
    t.boolean  "organic"
    t.integer  "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "englishName"
  end

  create_table "products", force: true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "country"
    t.integer  "enterprise"
    t.integer  "verifyDigit"
    t.integer  "product_type_id"
    t.integer  "packing_type_id"
  end

  add_index "products", ["packing_type_id"], name: "index_products_on_packing_type_id", using: :btree
  add_index "products", ["product_type_id"], name: "index_products_on_product_type_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",       null: false
    t.string   "encrypted_password",     default: "",       null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,        null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role",                   default: "client"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
