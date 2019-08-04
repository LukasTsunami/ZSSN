class AddAasmStateToSurvivors < ActiveRecord::Migration[5.2]
  def change
    add_column :survivors, :aasm_state, :string
  end
end
