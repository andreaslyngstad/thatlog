class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|   
	    t.string  :role
      t.string 	:phone
      t.string 	:name
      t.integer :firm_id
      t.string  :loginable_token,     :limit => 60
      t.float   :hourly_rate
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
