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

ActiveRecord::Schema.define(:version => 20110619030813) do

  create_table "people", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.string   "lat"
    t.string   "long"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "city"
    t.string   "state"
    t.string   "facebook_id"
    t.boolean  "allow_texts", :default => true
  end

  create_table "pets", :force => true do |t|
    t.integer  "shelter_id"
    t.string   "petharbor_id"
    t.string   "name"
    t.string   "color"
    t.string   "gender"
    t.string   "breed"
    t.integer  "age"
    t.date     "brought_to_shelter_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_uri"
  end

  create_table "shelters", :force => true do |t|
    t.string   "name"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "shelter_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
