class AddUserForeignKeyToAccount < ActiveRecord::Migration
  def change
    add_foreign_key :users, :accounts
  end
end
