class AddHoursToLog < ActiveRecord::Migration
  def self.up
  	add_column :logs, :hours, :float
  end

  def self.down
  	remove_column :logs, :hours
  end
end
