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

ActiveRecord::Schema.define(version: 2018_10_10_135225) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "vendor_id"
    t.bigint "shop_id"
    t.string "start_date"
    t.string "start_time"
    t.datetime "start_at"
    t.string "end_date"
    t.string "end_time"
    t.datetime "end_at"
    t.string "shopify_order_id"
    t.string "shopify_customer_name"
    t.string "shopify_order_line_item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_bookings_on_product_id"
    t.index ["shop_id"], name: "index_bookings_on_shop_id"
    t.index ["vendor_id"], name: "index_bookings_on_vendor_id"
  end

  create_table "cd_classes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "payouts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "vendor_id"
    t.float "amount_sold"
    t.float "amount_commissions_earned"
    t.float "amount_to_be_paid_out"
    t.integer "shop_id"
    t.string "status", default: "unpaid"
    t.datetime "paid_date"
    t.string "payment_type"
    t.text "payment_info"
    t.integer "product_id"
  end

  create_table "product_bookings", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "time_slot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_bookings_on_product_id"
    t.index ["time_slot_id"], name: "index_product_bookings_on_time_slot_id"
  end

  create_table "products", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "shop_id"
    t.decimal "minimum_commission_per_product"
    t.string "commission_structure_type"
    t.integer "vendor_id"
    t.string "shopify_id"
    t.string "title"
    t.decimal "cost_of_goods"
    t.integer "stocks_available"
    t.boolean "is_bookable", default: false
  end

  create_table "settings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "minimum_commission_per_product"
    t.string "structure_type"
    t.integer "shop_id"
    t.string "stripe_account_id"
    t.string "client_calendar_shop_path"
    t.string "client_calendar_html_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "shopify_domain", null: false
    t.string "shopify_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "admin_user_id"
    t.index ["shopify_domain"], name: "index_shops_on_shopify_domain", unique: true
  end

  create_table "time_slots", force: :cascade do |t|
    t.integer "shop_id"
    t.string "description"
    t.string "start_date"
    t.string "start_time"
    t.datetime "start_at"
    t.string "end_date"
    t.string "end_time"
    t.datetime "end_at"
    t.boolean "is_all_day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "shop_id"
    t.string "role"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vendor_invites", force: :cascade do |t|
    t.integer "user_id"
    t.integer "vendor_id"
    t.string "status", default: "invite_sent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "shop_id"
    t.string "email"
    t.datetime "accepted_at"
  end

  create_table "vendors", force: :cascade do |t|
    t.string "business_name"
    t.integer "shop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "poc_first_name"
    t.string "poc_last_name"
    t.string "phone_number"
    t.string "tax_id"
    t.text "address"
    t.string "status", default: "Active"
    t.string "stripe_account_id"
    t.integer "user_id"
    t.integer "product_id"
    t.index ["email"], name: "index_vendors_on_email", unique: true
  end

end
