class AddStatusToRegions < ActiveRecord::Migration[6.1]
  def change
    add_column :regions, :active_status, :boolean, default: true
    add_column :regions, :del_status, :boolean, default: false
  end
end
