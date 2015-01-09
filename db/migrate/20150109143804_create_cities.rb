class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.references :country
      t.string :name
      t.string :slug
      t.boolean :principal

      t.timestamps
    end
  end
end
