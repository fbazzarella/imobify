class AddCityForeignKeyToCountry < ActiveRecord::Migration
  def change
    add_foreign_key :cities, :countries
  end
end
