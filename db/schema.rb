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

ActiveRecord::Schema.define(version: 20151029122856) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_ingredients", force: true do |t|
    t.string "name"
    t.string "english_name"
    t.text   "description"
    t.string "slug"
  end

  create_table "addresses", force: true do |t|
    t.string  "first_name"
    t.string  "last_name"
    t.string  "address_line1"
    t.string  "address_line2"
    t.string  "city"
    t.string  "country_code"
    t.string  "state_code"
    t.string  "postal_code"
    t.string  "phone_number"
    t.string  "email"
    t.string  "status"
    t.boolean "billing"
    t.boolean "shipping"
    t.integer "user_id"
    t.string  "slug"
  end

  create_table "categories", force: true do |t|
    t.string  "name"
    t.string  "english_name"
    t.text    "description"
    t.string  "image"
    t.string  "slug"
    t.integer "category_id"
  end

  create_table "crystals", force: true do |t|
    t.string  "name"
    t.string  "english_name"
    t.integer "price"
    t.string  "chemical_formula"
    t.string  "image"
    t.string  "hardness"
    t.text    "qualities"
    t.text    "use_instructions"
    t.text    "warnings"
    t.string  "slug"
    t.string  "image_link"
  end

  create_table "essential_oils", force: true do |t|
    t.string   "name"
    t.string   "english_name"
    t.text     "use_instructions"
    t.text     "warnings"
    t.integer  "price_5ml"
    t.integer  "price_10ml"
    t.integer  "price_50ml"
    t.string   "image"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "free_plants_orders", force: true do |t|
    t.integer  "address_id"
    t.string   "plant_1"
    t.string   "plant_2"
    t.string   "delivery_method"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jewelries", force: true do |t|
    t.string   "name"
    t.string   "english_name"
    t.text     "long_description"
    t.float    "price"
    t.integer  "crystal_id"
    t.string   "image"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jewelry_crystals", force: true do |t|
    t.integer "jewelry_id"
    t.integer "crystal_id"
    t.integer "price"
    t.string  "slug"
  end

  create_table "medical_activities", force: true do |t|
    t.string "name"
    t.string "english_name"
    t.text   "description"
    t.string "slug"
  end

  create_table "medicinal_herb_active_ingredients", force: true do |t|
    t.integer "medicinal_herb_id"
    t.integer "active_ingredient_id"
  end

  create_table "medicinal_herb_medical_activities", force: true do |t|
    t.integer "medicinal_herb_id"
    t.integer "medical_activity_id"
  end

  create_table "medicinal_herbs", force: true do |t|
    t.string "name"
    t.string "english_name"
    t.string "latin_name"
    t.text   "description"
    t.text   "medicinal_properties"
    t.text   "use_instructions"
    t.text   "warnings"
    t.string "image"
    t.string "sprout_image"
    t.string "other_qualities"
    t.string "slug"
  end

  create_table "orders", force: true do |t|
    t.string   "status"
    t.string   "delivery_method"
    t.integer  "shipping_address_id"
    t.integer  "billing_address_id"
    t.integer  "user_id"
    t.string   "reference_id"
    t.string   "confirmation_number"
    t.string   "tracking_number"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_medicinal_herbs", force: true do |t|
    t.integer "medicinal_herb_id"
    t.integer "product_id"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.string   "english_name"
    t.text     "short_description"
    t.text     "long_description"
    t.text     "use_instructions"
    t.text     "ingridience"
    t.text     "warnings"
    t.float    "price"
    t.integer  "stock"
    t.integer  "category_id"
    t.string   "image"
    t.integer  "quantity"
    t.string   "quantity_unit"
    t.integer  "package_weight"
    t.float    "energy"
    t.float    "carbohydrates"
    t.float    "protein"
    t.float    "fat"
    t.float    "saturated_fat"
    t.float    "cholesterol"
    t.float    "sodium"
    t.text     "other_nutrients"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "medium_package_quantity"
    t.integer  "medium_package_price"
    t.integer  "big_package_quantity"
    t.integer  "big_package_price"
  end

  create_table "recipes", force: true do |t|
    t.string   "title"
    t.text     "text"
    t.string   "image"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "research_links", force: true do |t|
    t.integer "medicinal_herb_id"
    t.string  "url"
  end

  create_table "shopping_bag_items", force: true do |t|
    t.integer  "product_id"
    t.integer  "position_id"
    t.string   "position_type"
    t.integer  "qty"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shopping_bag_items", ["position_id", "position_type"], name: "index_shopping_bag_items_on_position_id_and_position_type", using: :btree

  create_table "shopping_cart_items", force: true do |t|
    t.integer  "sellable_id"
    t.integer  "position_id"
    t.string   "position_type"
    t.integer  "qty"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sellable_type"
    t.string   "package_type"
  end

  add_index "shopping_cart_items", ["position_id", "position_type"], name: "index_shopping_cart_items_on_position_id_and_position_type", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "role",            default: "customer"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
  end

  create_table "wishlist_items", force: true do |t|
    t.integer  "sellable_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sellable_type"
  end

end
