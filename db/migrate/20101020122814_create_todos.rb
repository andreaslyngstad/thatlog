class CreateTodos < ActiveRecord::Migration
  def self.up
    create_table :todos do |t|
      t.string :name
      t.integer :user_id
      t.integer :firm_id
      t.integer :project_id
      t.integer :customer_id
      t.date :due
      t.boolean :completed
      t.timestamps
    end
  end

  def self.down
    drop_table :todos
  end
end
