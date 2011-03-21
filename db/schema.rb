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

ActiveRecord::Schema.define(:version => 20101029201137) do

  create_table "customers", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.string   "address"
    t.integer  "firm_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employees", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "firms", :force => true do |t|
    t.string   "name"
    t.string   "subdomain"
    t.string   "address"
    t.string   "phone"
    t.string   "currency"
    t.string   "lang"
    t.string   "time_zone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logs", :force => true do |t|
    t.string   "event"
    t.integer  "customer_id"
    t.integer  "user_id"
    t.integer  "firm_id"
    t.integer  "project_id"
    t.integer  "employee_id"
    t.integer  "todo_id"
    t.boolean  "tracking"
    t.datetime "begin_time"
    t.datetime "end_time"
    t.datetime "log_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "memberships", :force => true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "milestones", :force => true do |t|
    t.string   "goal"
    t.date     "due"
    t.integer  "firm_id"
    t.boolean  "completed"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.date     "due"
    t.boolean  "active"
    t.float    "budget"
    t.float    "hour_price"
    t.integer  "firm_id"
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "todos", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "firm_id"
    t.integer  "project_id"
    t.integer  "customer_id"
    t.date     "due"
    t.boolean  "completed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt_password"
    t.string   "persistence_token"
    t.string   "phone"
    t.string   "name"
    t.integer  "firm_id"
    t.boolean  "manager"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end