class AddStatusToCities < ActiveRecord::Migration[6.1]
  def change
    add_column :cities, :active_status, :boolean, default: true
    add_column :cities, :del_status, :boolean, default: false
  end
end
