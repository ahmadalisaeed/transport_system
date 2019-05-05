# frozen_string_literal: true

class CreateLines < ActiveRecord::Migration[5.2]
  def change
    create_table :lines do |t|
      t.integer :source_id
      t.string :name

      t.timestamps

      t.index :source_id, unique: true
    end
  end
end
