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

ActiveRecord::Schema.define(version: 20151123170743) do

  create_table "chair_admins", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "chair_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "chair_admins", ["chair_id"], name: "index_chair_admins_on_chair_id"
  add_index "chair_admins", ["user_id"], name: "index_chair_admins_on_user_id"

  create_table "chair_applications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "chair_id"
    t.integer  "status",     default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "chair_applications", ["chair_id"], name: "index_chair_applications_on_chair_id"
  add_index "chair_applications", ["user_id"], name: "index_chair_applications_on_user_id"

  create_table "chair_representatives", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "chair_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "chair_representatives", ["chair_id"], name: "index_chair_representatives_on_chair_id"
  add_index "chair_representatives", ["user_id"], name: "index_chair_representatives_on_user_id"

  create_table "chair_wimis", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "chair_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "chair_wimis", ["chair_id"], name: "index_chair_wimis_on_chair_id"
  add_index "chair_wimis", ["user_id"], name: "index_chair_wimis_on_user_id"

  create_table "chairs", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "chairs", ["user_id"], name: "index_chairs_on_user_id"

  create_table "expenses", force: :cascade do |t|
    t.decimal  "amount"
    t.text     "purpose"
    t.text     "comment"
    t.integer  "user_id"
    t.integer  "project_id"
    t.integer  "trip_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "expenses", ["project_id"], name: "index_expenses_on_project_id"
  add_index "expenses", ["trip_id"], name: "index_expenses_on_trip_id"
  add_index "expenses", ["user_id"], name: "index_expenses_on_user_id"

  create_table "holidays", force: :cascade do |t|
    t.string   "status"
    t.datetime "start"
    t.datetime "end"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "holidays", ["user_id"], name: "index_holidays_on_user_id"

  create_table "projects", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "project_id"
  end

  add_index "projects_users", ["project_id"], name: "index_projects_users_on_project_id"
  add_index "projects_users", ["user_id"], name: "index_projects_users_on_user_id"

  create_table "publications", force: :cascade do |t|
    t.string   "title"
    t.string   "venue"
    t.string   "type_"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "publications", ["project_id"], name: "index_publications_on_project_id"

  create_table "publications_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "publication_id"
  end

  add_index "publications_users", ["publication_id"], name: "index_publications_users_on_publication_id"
  add_index "publications_users", ["user_id"], name: "index_publications_users_on_user_id"

  create_table "trips", force: :cascade do |t|
    t.string   "title"
    t.datetime "start"
    t.datetime "end"
    t.string   "status"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "trips", ["user_id"], name: "index_trips_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",     null: false
    t.string   "encrypted_password",     default: "",     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "first"
    t.string   "last_name"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "role",                   default: "user"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
