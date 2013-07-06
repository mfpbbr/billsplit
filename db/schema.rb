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

ActiveRecord::Schema.define(:version => 20130706000701) do

  create_table "bills", :force => true do |t|
    t.integer  "user_id"
    t.string   "description"
    t.integer  "total_amount"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "debts", :force => true do |t|
    t.integer  "bill_id"
    t.integer  "debtor_id"
    t.integer  "creditor_id"
    t.integer  "amount"
    t.boolean  "is_a_payment"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "memo"
  end

  create_table "friendships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "guests", :force => true do |t|
    t.integer  "user_id"
    t.integer  "bill_id"
    t.integer  "amount_paid"
    t.integer  "amount_should_have_paid"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "username"
  end

  create_table "nudges", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.boolean  "viewed"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.string   "session_token"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "email"
    t.integer  "money_lent"
    t.integer  "money_borrowed"
  end

end
