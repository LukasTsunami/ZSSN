class ChangeLatitudeAndLongitudeStoredDatatype < ActiveRecord::Migration[5.2]
  def change
    change_column :survivors, :latitude, :decimal, { precision: 10, scale: 6 }
    change_column :survivors, :longitude, :decimal, { precision: 10, scale: 6 }
  end
end
