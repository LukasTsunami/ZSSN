# frozen_string_literal: true

class AddInfectedToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :infected, :boolean, default: false, null: false
  end
end
