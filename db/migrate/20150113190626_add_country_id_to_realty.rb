class AddCountryIdToRealty < ActiveRecord::Migration
  def change
    add_column :realties, :country_id, :integer
  end
end
