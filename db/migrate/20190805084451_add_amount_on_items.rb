class AddAmountOnItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :amount, :integer, default: 0, null: false
  end
end
