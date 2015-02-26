class AddDomainForeignKeyToAccount < ActiveRecord::Migration
  def change
    add_foreign_key :domains, :accounts
  end
end
