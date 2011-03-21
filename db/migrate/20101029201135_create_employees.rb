class CreateEmployees < ActiveRecord::Migration
  def self.up
    create_table :employees do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.integer :customer_id

      t.timestamps
    end
  end

  def self.down
    drop_table :employees
  end
end
