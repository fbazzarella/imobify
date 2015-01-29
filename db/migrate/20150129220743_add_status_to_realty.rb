class AddStatusToRealty < ActiveRecord::Migration
  def change
    add_column :realties, :status, :string, limit: 255
  end
end
