# frozen_string_literal: true

class ChangeInfectedDefaultOnSurvivor < ActiveRecord::Migration[5.2]
    def change
      change_column :survivors, :infected, :boolean, default: false, not: :null
    end
end