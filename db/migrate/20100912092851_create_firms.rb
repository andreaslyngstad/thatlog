class CreateFirms < ActiveRecord::Migration
  def self.up
    create_table :firms do |t|
           t.string :name
           t.string :subdomain
           t.string :address
           t.string :phone
           t.string :currency
           t.string :lang
           t.string :time_zone
      t.timestamps
    end
  end

  def self.down
    drop_table :firms
  end
end
