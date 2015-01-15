class ChangeSomeRealtyFields < ActiveRecord::Migration
  def change
    change_column :realties, :size,  :integer
    change_column :realties, :price, :integer
    change_column :realties, :taxes, :integer
  end
end
