class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :realty
      t.string :file

      t.timestamps null: false
    end

    add_foreign_key :photos, :realties
  end
end
