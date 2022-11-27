# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_11_24_120006) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_employees_on_company_id"
  end

  create_table "events", force: :cascade do |t|
    t.bigint "recurring_event_id", null: false
    t.datetime "happens_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recurring_event_id"], name: "index_events_on_recurring_event_id"
  end

  create_table "groups", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_groups_on_event_id"
  end

  create_table "groups_participations", force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "participation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_groups_participations_on_group_id"
    t.index ["participation_id"], name: "index_groups_participations_on_participation_id"
  end

  create_table "participations", force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_participations_on_employee_id"
    t.index ["event_id"], name: "index_participations_on_event_id"
  end

  create_table "recurring_events", force: :cascade do |t|
    t.string "name", null: false
    t.integer "weekday", null: false
    t.time "time", null: false
    t.integer "group_size", null: false
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_recurring_events_on_company_id"
  end

  add_foreign_key "employees", "companies"
  add_foreign_key "events", "recurring_events"
  add_foreign_key "groups", "events"
  add_foreign_key "groups_participations", "groups"
  add_foreign_key "groups_participations", "participations"
  add_foreign_key "participations", "employees"
  add_foreign_key "participations", "events"
  add_foreign_key "recurring_events", "companies"
end
