# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_190_504_141_454) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'arrival_times', force: :cascade do |t|
    t.bigint 'line_id'
    t.bigint 'stop_id'
    t.time 'arrives_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[line_id stop_id], name: 'index_arrival_times_on_line_id_and_stop_id', unique: true
    t.index ['line_id'], name: 'index_arrival_times_on_line_id'
    t.index ['stop_id'], name: 'index_arrival_times_on_stop_id'
  end

  create_table 'delays', force: :cascade do |t|
    t.bigint 'line_id'
    t.integer 'delay_in_minutes'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['line_id'], name: 'index_delays_on_line_id'
  end

  create_table 'lines', force: :cascade do |t|
    t.integer 'source_id'
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['source_id'], name: 'index_lines_on_source_id', unique: true
  end

  create_table 'stops', force: :cascade do |t|
    t.integer 'source_id'
    t.integer 'x'
    t.integer 'y'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['source_id'], name: 'index_stops_on_source_id', unique: true
  end

  add_foreign_key 'arrival_times', 'lines'
  add_foreign_key 'arrival_times', 'stops'
  add_foreign_key 'delays', 'lines'
end
