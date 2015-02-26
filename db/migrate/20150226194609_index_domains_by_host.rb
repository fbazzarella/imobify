class IndexDomainsByHost < ActiveRecord::Migration
  def change
    add_index :domains, :host, unique: true
  end
end
