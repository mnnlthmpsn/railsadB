class AddDefaultsToTowns < ActiveRecord::Migration[6.1]
  def change
    change_column :towns, :active_status, :boolean, default: true
    change_column :towns, :del_status, :boolean, default:  false
  end
end
