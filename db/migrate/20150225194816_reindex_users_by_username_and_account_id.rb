class ReindexUsersByUsernameAndAccountId < ActiveRecord::Migration
  def change
    remove_index :users, column: :username,        unique: true
    add_index    :users, [:username, :account_id], unique: true
  end
end
