class RemoveThemeFromAccount < ActiveRecord::Migration
  def change
    remove_column :accounts, :theme, :string, limit: 255
  end
end
