# frozen_string_literal: true

class CreateStops < ActiveRecord::Migration[5.2]
  def change
    create_table :stops do |t|
      t.integer :source_id
      t.integer :x
      t.integer :y

      t.timestamps

      t.index :source_id, unique: true
    end
  end
end
