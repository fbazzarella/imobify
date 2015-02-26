class AddAccountIdToRealty < ActiveRecord::Migration
  def change
    add_column :realties, :account_id, :integer
  end
end
