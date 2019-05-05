# frozen_string_literal: true

class CreateArrivalTimes < ActiveRecord::Migration[5.2]
  def change
    create_table :arrival_times do |t|
      t.references :line, foreign_key: true
      t.references :stop, foreign_key: true

      t.time :arrives_at

      t.timestamps

      t.index %i[line_id stop_id], unique: true
    end
  end
end
