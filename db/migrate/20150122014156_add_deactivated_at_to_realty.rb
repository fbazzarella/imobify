class AddDeactivatedAtToRealty < ActiveRecord::Migration
  def change
    add_column :realties, :deactivated_at, :datetime
  end
end
