class CreateDomains < ActiveRecord::Migration
  def change
    create_table :domains do |t|
      t.references :account
      t.string :host

      t.timestamps null: false
    end
  end
end
