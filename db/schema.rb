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

ActiveRecord::Schema.define(version: 20160122181356) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_products", id: false, force: :cascade do |t|
    t.integer "product_id",  null: false
    t.integer "category_id", null: false
  end

  create_table "orderitems", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.integer  "quantity",   default: 1
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "shipped",    default: false
  end

  create_table "orders", force: :cascade do |t|
    t.string   "status"
    t.string   "email"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "credit_name"
    t.string   "credit_num"
    t.string   "cvv"
    t.datetime "exp_date"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.datetime "purchase_time"
    t.string   "ship_city"
    t.string   "ship_state"
    t.string   "ship_zip"
    t.string   "ship_choice"
    t.integer  "ship_price"
  end

  create_table "product_items", force: :cascade do |t|
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "orderitem_id"
    t.integer  "product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price",       precision: 8, scale: 2
    t.integer  "robot_id"
    t.string   "picture_url"
    t.integer  "stock"
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.string   "description"
    t.boolean  "retire",                              default: false
    t.integer  "weight"
    t.integer  "length"
    t.integer  "width"
    t.integer  "height"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "rating"
    t.string   "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "robots", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
