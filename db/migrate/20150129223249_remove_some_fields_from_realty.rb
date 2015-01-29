class RemoveSomeFieldsFromRealty < ActiveRecord::Migration
  def change
    remove_column :realties, :published, :string, limit: 255
    remove_column :realties, :deactivated_at, :datetime
  end
end
