class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.date :due
      t.boolean :active
      t.float :budget
      t.float :hour_price
      t.integer :firm_id
      t.integer :customer_id
      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
