# frozen_string_literal: true

class CreateInventory < ActiveRecord::Migration[5.2]
  def change
    create_table :inventory do |t|
      t.references :item, foreign_key: true
      t.references :survivor, foreign_key: true

      t.timestamps
    end
  end
end
