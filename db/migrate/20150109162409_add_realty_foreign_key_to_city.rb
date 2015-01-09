class AddRealtyForeignKeyToCity < ActiveRecord::Migration
  def change
    add_foreign_key :realties, :cities
  end
end
