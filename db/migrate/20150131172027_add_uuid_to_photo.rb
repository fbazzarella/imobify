class AddUuidToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :uuid, :string, limit: 255
  end
end
