class CreateRegions < ActiveRecord::Migration[6.1]
  def change
    create_table :regions do |t|
      t.string :region_desc
      t.text :comment

      t.timestamps
    end
  end
end
