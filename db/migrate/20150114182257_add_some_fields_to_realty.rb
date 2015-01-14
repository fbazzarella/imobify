class AddSomeFieldsToRealty < ActiveRecord::Migration
  def change
    add_column :realties, :neighborhood,   :string, limit: 255
    add_column :realties, :street,         :string, limit: 255
    add_column :realties, :business_kind,  :string, limit: 255
    add_column :realties, :realty_kind,    :string, limit: 255
    add_column :realties, :rooms,          :integer
    add_column :realties, :bathrooms,      :integer
    add_column :realties, :parking_spaces, :integer
    add_column :realties, :size,           :decimal, precision: 14, scale: 2
    add_column :realties, :price,          :decimal, precision: 14, scale: 2
    add_column :realties, :taxes,          :decimal, precision: 14, scale: 2
    add_column :realties, :description,    :text
    add_column :realties, :published,      :boolean, default: false
  end
end
