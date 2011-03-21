class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      
      t.string :email
      t.string :crypted_password
      t.string :salt_password
      t.string :persistence_token
      t.string :phone
      t.string :name
      t.integer :firm_id
      t.boolean :manager
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
