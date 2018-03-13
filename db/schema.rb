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

ActiveRecord::Schema.define(version: 20180307193148) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
  end

  create_table "categories_jobs", id: false, force: :cascade do |t|
    t.bigint "job_id", null: false
    t.bigint "category_id", null: false
  end

  create_table "categories_projects", id: false, force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "category_id", null: false
  end

  create_table "categories_subscriptions", id: false, force: :cascade do |t|
    t.integer "category_id"
    t.integer "subscription_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "title"
    t.string "location"
    t.text "description"
    t.integer "time_commitment"
    t.string "organisation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "url"
    t.date "expiry_date"
    t.string "owner_id"
    t.string "owner_name"
    t.bigint "user_id"
    t.bigint "category_id"
    t.float "latitude"
    t.float "longitude"
    t.index ["user_id"], name: "index_jobs_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "organisation"
    t.string "owner_id"
    t.string "owner_name"
    t.string "contact_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.integer "upvotes"
    t.integer "budget"
    t.bigint "category_id"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "sent_emails", force: :cascade do |t|
    t.bigint "user_id"
    t.string "email"
    t.string "status"
    t.string "handler_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sent_emails_on_user_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_subscriptions_on_category_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "uid"
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin"
  end

  create_table "votes", id: :serial, force: :cascade do |t|
    t.string "votable_type"
    t.integer "votable_id"
    t.string "voter_type"
    t.integer "voter_id"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
  end

  add_foreign_key "jobs", "users"
  add_foreign_key "projects", "users"
  add_foreign_key "sent_emails", "users"
  add_foreign_key "subscriptions", "categories"
  add_foreign_key "subscriptions", "users"
end
