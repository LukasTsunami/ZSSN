# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :points_value
      t.string :image_url

      t.timestamps
    end
  end
end
