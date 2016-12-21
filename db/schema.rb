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

ActiveRecord::Schema.define(version: 20161204110704) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "candidates", force: :cascade do |t|
    t.string   "name"
    t.string   "office"
    t.string   "party_affiliation"
    t.string   "zip"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "electioninfos", force: :cascade do |t|
    t.string   "title",      null: false
    t.string   "subtitle"
    t.string   "url",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reminder_emails", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "subject"
  end

  create_table "state_election_infos", force: :cascade do |t|
    t.string   "election_title"
    t.string   "election_date"
    t.string   "voter_registration"
    t.string   "absentee_ballot_request"
    t.string   "absentee_ballot_return"
    t.string   "early_in_person_voting"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "state_voting_informations", force: :cascade do |t|
    t.string   "name"
    t.boolean  "early_in_person_voting"
    t.boolean  "no_excuse_absentee_voting"
    t.boolean  "absentee_voting_with_excuse"
    t.boolean  "same_day_voter_registration"
    t.string   "all_mail_voting"
    t.string   "provisional_voting"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "sos_url"
  end

  create_table "state_websites", force: :cascade do |t|
    t.string   "name"
    t.string   "initials"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "street_address"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.boolean  "subscribe",       default: true
    t.string   "token"
  end

  create_table "zipcodes", force: :cascade do |t|
    t.string   "zip"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "state_name"
    t.string   "abbreviation"
  end

end
