class AddSomeFieldsToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :phone, :string, limit: 255
    add_column :accounts, :mobile, :string, limit: 255
    add_column :accounts, :email, :string, limit: 255
  end
end
