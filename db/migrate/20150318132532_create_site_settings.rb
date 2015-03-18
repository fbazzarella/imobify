class CreateSiteSettings < ActiveRecord::Migration
  def change
    create_table :site_settings do |t|
      t.references :account, index: true
      t.string :title
      t.string :logo
      t.string :template
      t.string :analytics_id

      t.timestamps null: false
    end

    add_foreign_key :site_settings, :accounts
  end
end
