class AddRealtyForeignKeyToAccount < ActiveRecord::Migration
  def change
    add_foreign_key :realties, :accounts
  end
end
