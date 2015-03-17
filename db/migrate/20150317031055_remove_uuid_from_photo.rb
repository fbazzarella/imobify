class RemoveUuidFromPhoto < ActiveRecord::Migration
  def change
    remove_column :photos, :uuid, :string, limit: 255
  end
end
