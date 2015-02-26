class AddThemeToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :theme, :string
  end
end
