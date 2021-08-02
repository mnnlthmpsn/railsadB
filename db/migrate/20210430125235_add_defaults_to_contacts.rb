class AddDefaultsToContacts < ActiveRecord::Migration[6.1]
  def change
    change_column :contacts, :active_status, :boolean, default: true
    change_column :contacts, :del_status, :boolean, default: false
  end
end
