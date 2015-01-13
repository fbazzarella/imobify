class AddRealtyForeignKeyToCountry < ActiveRecord::Migration
  def change
    add_foreign_key :realties, :countries
  end
end
