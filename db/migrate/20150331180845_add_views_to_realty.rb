class AddViewsToRealty < ActiveRecord::Migration
  def change
    add_column :realties, :views, :integer, default: 0
  end
end
