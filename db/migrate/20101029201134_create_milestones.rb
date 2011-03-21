class CreateMilestones < ActiveRecord::Migration
  def self.up
    create_table :milestones do |t|
      t.string :goal
      t.date :due
      t.integer :firm_id
      t.boolean :completed
      t.integer :project_id

      t.timestamps
    end
  end

  def self.down
    drop_table :milestones
  end
end
