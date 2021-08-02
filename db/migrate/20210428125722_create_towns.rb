class CreateTowns < ActiveRecord::Migration[6.1]
  def change
    create_table :towns do |t|
      t.string :town_desc
      t.text :comment
      t.references :city, null: false, foreign_key: true
      t.boolean :active_status
      t.boolean :del_status

      t.timestamps
    end
  end
end
