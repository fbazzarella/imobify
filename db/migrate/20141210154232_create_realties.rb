class CreateRealties < ActiveRecord::Migration
  def change
    create_table :realties do |t|
      t.string :reference

      t.timestamps
    end
  end
end
