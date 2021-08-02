class CreateCities < ActiveRecord::Migration[6.1]
  def change
    create_table :cities do |t|
      t.string :city_desc
      t.references :region, null: false, foreign_key: true
      t.text :comment

      t.timestamps
    end
  end
end
