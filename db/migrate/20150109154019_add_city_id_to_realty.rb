class AddCityIdToRealty < ActiveRecord::Migration
  def change
    add_column :realties, :city_id, :integer
  end
end
