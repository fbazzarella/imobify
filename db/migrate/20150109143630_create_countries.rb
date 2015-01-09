class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :initial
      t.string :name
      t.string :slug

      t.timestamps
    end
  end
end
