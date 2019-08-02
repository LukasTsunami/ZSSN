# frozen_string_literal: true

class CreateSurvivors < ActiveRecord::Migration[5.2]
  def change
    create_table :survivors do |t|
      t.string :name
      t.integer :age
      t.string :gender
      t.float :latitude
      t.float :longitude
      t.boolean :infected
      t.references :items, foreign_key: true

      t.timestamps
    end
  end
end
