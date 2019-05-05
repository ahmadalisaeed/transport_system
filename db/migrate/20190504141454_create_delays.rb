# frozen_string_literal: true

class CreateDelays < ActiveRecord::Migration[5.2]
  def change
    create_table :delays do |t|
      t.references :line, foreign_key: true
      t.integer :delay_in_minutes

      t.timestamps
    end
  end
end
